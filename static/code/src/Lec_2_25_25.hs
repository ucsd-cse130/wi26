{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}
{-# HLINT ignore "Use uncurry" #-}
{-# HLINT ignore "Use foldr" #-}
{-# HLINT ignore "Use camelCase" #-}

module Lec_2_25_25  where

import Prelude hiding (lookup)
import Data.List (delete)
import Data.Text.Internal.Encoding.Utf16 (validate2)

data Value
  = VInt Int
  | VFun Id Expr Env
  deriving (Show)

type Id    = String

data Bin = Add | Sub | Mul
  deriving (Show)

data Expr
  = ENum Int            -- n
  | EBin Bin Expr Expr  -- e1 + e2
  | EVar Id             -- x,y,z
  | ELet Id Expr Expr   -- let x = e1 in e2

  -- THE NEW STUFF

  | ELam Id Expr        -- (\x -> e)
  | EApp Expr Expr      -- (e1 e2)
  deriving (Show)

-- >>> 2+2

{-
                      ENV
  let x = 5 + 5 in
                        [x := 10, ENV]

    let y = x + 10 in
                        [y := 20, x := 10, ENV]
      x + y



                        ENV
  let inc = \z -> z + 1
                        [inc := << z | z + 1>>, ENV]

    let y = 5 + 5 in

                        [y := 10, inc := << z | z + 1>>, ENV]
      inc   y
      {e1}  {e2}
"evaluate" body `z + 1` in an `env` [z := 10] (10 is arg)

-}






-- let inc = \x -> x + 1 in
--   let y = 5 + 5 in
--      inc (5 + 5)
exInc :: Expr
        -- []
exInc = ELet "inc" (ELam "x" (EBin Add (EVar "x") (ENum 1)))
        -- [(inc, VFun "x" (x + 1))]
          (ELet "y" (EBin Add (ENum 5) (ENum 5))
        -- [(y, 10), (inc, VFun "x" (x + 1))]
            (EApp (EVar "inc") (EVar "y")))


                                  -- []
-- let c = 1 in
                                  -- ["c" := 1]
--   let inc = \x -> x + c in
                                  -- ["inc" := < x | x + c | ["c" := 1] >, "c" := 1]
--     let y = 5 + 5 in
                                  -- [y := 10, "inc" := < x | x + c | ["c" := 1] >, "c" := 1]
--        inc y
                                  -- eval [ ("x" := 10),"c" := 1  ]  (x + c)

exIncC :: Expr
exIncC =
  ELet "c" (ENum 1)
    (ELet "inc" (ELam "x" (EBin Add (EVar "x") (EVar "c")))
      (ELet "y" (EBin Add (ENum 5) (ENum 5))
        (EApp (EVar "inc") (EVar "y"))))

exInc2C :: Expr
exInc2C =
  ELet "c" (ENum 1)
    (ELet "inc" (ELam "x" (EBin Add (EVar "x") (EVar "c")))
      (ELet "y" (EBin Add (ENum 5) (ENum 5))
        (ELet "c" (ENum 100)
          (EApp (EVar "inc") (EVar "y")))))


-- >>> eval [] exInc2C
-- VInt 11


-- >>> eval [] exIncC
-- VInt 11

-- >>> eval [] exInc
-- VInt 11


-- let adder = \x -> (\y -> x + y) in
--   let add10 = adder 10 in
--     add10 99

-- let adder = \x y z -> ... in
--   adder 10 20 30
exAdder :: Expr
exAdder =

  -- []
  ELet "adder" (ELam "x" (ELam "y" (EBin Add (EVar "x") (EVar "y"))))
  -- ["adder" := < x | \y -> x + y | [] >  ]
    (ELet "add10" (EApp (EVar "adder") (ENum 10))
  -- ["add10" := < y | x + y | [x := 10] > ,  "adder" := < x | \y -> x + y | [] >  ]
       (EApp (EVar "add10") (ENum 99)))

{-
eval ["adder" := < x | \y -> x + y | [] > ] (App adder 10)

  adder --> < x | \y -> x + y | [] >
  10    --> 10

  eval [x:=10]  (\y -> x + y) --> < y | x + y | [x := 10] >

-}


-- >>> eval [] exAdder
-- VInt 109

{-

let x = e1 in e2        <==>       (\x -> e2)  e1

let adder = (\x -> (\y -> x + y)) in
  let add10 = adder 10 in
    add10 99

==>

let adder = (\x -> (\y -> x + y)) in
  (\add10 -> add10 99) (adder 10)

==>

  (\adder -> (\add10 -> add10 99) (adder 10)) ((\x -> (\y -> x + y)))




let adder = (\x -> (\y -> x + y)) in
  let add10 = adder 10 in
    add10 99

==>

  let add10 = (\x -> (\y -> x + y))  10 in
    add10 99

==>
  let add10 = (\y -> 10 + y) in
    add10 99

==>
    (\y -> 10 + y) 99

==>
    109
-}


e0 :: Expr
e0 = EBin Sub (EBin Add (ENum 4) (ENum 12)) (ENum 5)

-- >>> eval [] (EVar "z97")
-- unbound variable: z97


-- >>> eval e0
-- 11

e_x_plus_1 :: Expr
e_x_plus_1 = EBin Add (EVar "x") (ENum 1)

e_x_plus_y :: Expr
e_x_plus_y = EBin Add (EVar "x") (EVar "y")


-- >>> eval [("x", 100), ("y", 200), ("z", 5001), ("x", 99)] e_x_plus_y

-- >>> eval [] exLet2
-- 21



type Env = [(Id, Value)]

eval :: Env -> Expr -> Value
eval _   (ENum n)       = VInt n
eval env (EBin o e1 e2) = evalOp o (eval env e1) (eval env e2)
eval env (EVar x)       = lookup x env
eval env (ELet x e1 e2) = eval ext_env e2
  where
    ext_env             = (x, v1) : env
    v1                  = eval env e1

eval env (ELam z body)  = VFun z body env

eval env (EApp e1 e2)   = case eval env e1 of
                            VInt n      -> error ("Yikes! " ++ show n ++ "is not a function!")
                            VFun z body frozEnv -> eval ((z, eval env e2) : frozEnv) body





-- eval env (ELet x e1 e2) = let v1 = eval env e1
--                               ext_env = (x, v1) : env
--                           in
--                             eval ext_env e2

{-
1. eval e1 in "current" env ==> v1
2. extend "current" env with x := v1 ==> ext_env
3. eval e2 in ext_env

-}

-- let x = 10 in x + 1



exLet0 :: Expr
exLet0 = ELet "x" (ENum 10)
            (EBin Add (EVar "x") (ENum 1))



-- >>> eval [] (EBin Add (ELam "z" (ENum 10)) (ENum 12))
-- Prelude.undefined

-- let x = 10 in (let x = 100 in x + 1)
-- >>> eval [] exLet1
-- VInt 101
exLet1 :: Expr
exLet1 = ELet "x" (ENum 10)
          (ELet "x" (ENum 100)
            (EBin Add (EVar "x") (ENum 1)))

-- let x = 10 in (let y = x + 1 in (x + y))
-- >>> eval [("z", 666)] exLet2
-- 676

-- >>> eval [] (ELet "x" (EVar "x") (EBin Add (EVar "x") (ENum 1)))
-- unbound variable: x

exLet2 :: Expr
exLet2 = ELet "x" (ENum 10)
          (ELet "y" (EBin Add (EVar "x") (ENum 1))
            (EBin Add (EVar "x") (EVar "z")))

-- HW exercise

freeVars :: Expr -> [Id]
freeVars (ENum _)       = []
freeVars (EVar x)       = [x]
freeVars (EBin _ e1 e2) = freeVars e1 ++ freeVars e2
freeVars (ELet x e1 e2) = freeVars e1 ++ delete x (freeVars e2)

-- fv (let x = x in x + 10)
-- fv x ++ (delete x (fv (x+10)))
-- [x] ++ (delete x (fv x ++ fv 10))
-- [x] ++ (delete x ([x] ++ []))
-- [x] ++ (delete x ([x]))
-- [x] ++ []
-- [x]

-- let x = 10 in x + 1    ==> []

-- let x = 10 in x + y    ==> [y]

-- let x = y  in x + 1    ==> [y]





lookup :: Id -> Env -> Value
lookup x []              = error ("unbound variable: " ++ x)
lookup x ((v, val):rest) = if v == x then val else lookup x rest



evalOp :: Bin -> Value -> Value -> Value
evalOp Add (VInt n1) (VInt n2) = VInt (n1 + n2)
evalOp Sub (VInt n1) (VInt n2) = VInt (n1 - n2)
evalOp Mul (VInt n1) (VInt n2) = VInt (n1 * n2)
evalOp _   v1        v2        = error ("OH GOD! Cannot do arith on " ++ show (v1, v2))

funny =
  let x = 0
  in
    (let x = 100
    in
      x + 1
    )
    +
    x

bunny =
  let x = 10 in
    (let y = 20 in
      (let z = 30 in
        x + y + z))

bunny' =
  let x = 10
      y = 20
      z = 30
  in
    x + y + z




blahblah =
  let c = 1
  in
    let inc = \x -> x + c
    in
       let c = 100
       in
         let a0 = inc 0
         in
           let c = 9999
           in
             let b0 = inc 0
             in
               a0 == b0
