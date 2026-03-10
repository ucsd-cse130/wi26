{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{- HLINT ignore "Use foldr" -}
{- HLINT ignore "Use map" -}
{- HLINT ignore "Eta reduce" -}

module Lec_2_17_2026 where

import Text.Printf (printf)
import Prelude hiding (map, filter, lookup)
import Data.Char (toUpper)
import Debug.Trace (trace)

type Ident = String
data Op
  = Add | Mul | Sub | Div
  deriving (Show)

data Expr
  = ENum Int              -- ^ n
  | EBin Op Expr Expr     -- ^ e1 `op` e2
  | EVar Ident            -- ^ x,y,z
  | ELet Ident Expr Expr  -- ^ let x = e1 in e2
  | ELam Ident Expr       -- ^ \x -> e
  | EApp Expr Expr        -- ^ e1 e2
  deriving (Show)

fac :: Int -> Int
fac n = let res = if n <= 1 then 1 else n * fac (n - 1)
            msg = printf "TRACE: called fac with %d, result = %d" n res
        in
           trace msg res
{-
                            -- []
 let incr = \x -> x + 1
                            -- eval [("x", 10), ("incr", VFun "x" "x+1")] "x+1"
 in
   incr 10
-}
exp5 :: Expr
                                                            -- []
exp5 = ELet "incr" (ELam "x" (EBin Add (EVar "x") (ENum 1)))
                                                            --
         (EApp (EVar "incr") (ENum 100))


{-                            -- []
let c = 1
in                            -- [("c", 1)]
  let inc = \x -> x + c
  in                          -- [("inc", <"x", "x+c">), ("c", 1)]
    inc 100
                                 eval [(x, 100), ("inc", <"x", "x+1">), ("c", 1)] "x + c"

-}

exp6 :: Expr
exp6 =
  ELet "c" (ENum 1) (
    ELet "incr" (ELam "x" (EBin Add (EVar "x") (EVar "c")))
      (EApp (EVar "incr") (ENum 100))
  )

-- >>> eval [] exp7
-- VInt 101


{-
                                []
let c = 1
in                              [(c, 1)]
  let inc = \x -> x + c
  in
      let c = 100
      in                         [(c, 100) , (inc, <x , x + c>), (c, 1)]
        inc 100
-}

exp7 :: Expr
exp7 =
  ELet "c" (ENum 1) (
    ELet "incr" (ELam "x" (EBin Add (EVar "x") (EVar "c"))) (
      ELet "c" (ENum 100) (
        EApp (EVar "incr") (ENum 100)
      )
    )
  )

{-                                      -- []
let add = \x -> (\y -> x + y)
in                                      -- [ (add, VFun [] "x" "(\y -> x + y)")]           -- ENV0
  let add10 = add 10
  in                                    -- [ (add10, VFun (("x", 10): []) "y" <x + y>)  -- ENV1
                                           , (add, VFun [] "x" "(\y -> x + y)" )]
    let add20 = add 20
    in                                  -- [ (add20, VFun (("x", 20): []) "y" <x + y>)
                                           , (add10, VFun (("x", 10): []) "y" <x + y>)
                                           , (add, VFun [] "x" "(\y -> x + y)" )]

      (add10 100) + (add20 1000)
-}

exp8 :: Expr
exp8 =
  ELet "add" (ELam "x" (ELam "y" (EBin Add (EVar "x") (EVar "y")))) (
    ELet "add10" (EApp (EVar "add") (ENum 10)) (
      ELet "add20" (EApp (EVar "add") (ENum 20)) (
        EBin Add (EApp (EVar "add10") (ENum 100)) (EApp (EVar "add20") (ENum 1000))
      )
    )
  )

{-
let add = \x -> (\y -> x + y)
in
  let add10 = add 10
  in
    let doTwice = \f -> (\x -> f (f x))
    in
      doTwice add10 100


[ ("add10",VFun [("x",VInt 10)] "y" (EBin Add (EVar "x") (EVar "y"))),
  ("add",VFun [] "x" (ELam "y" (EBin Add (EVar "x") (EVar "y"))))
 ]
-}

exp9 :: Expr
exp9 =
  ELet "add" (ELam "x" (ELam "y" (EBin Add (EVar "x") (EVar "y")))) (
    ELet "add10" (EApp (EVar "add") (ENum 10)) (
      ELet "doTwice" (ELam "f" (ELam "x" (EApp (EVar "f") (EApp (EVar "f") (EVar "x"))))) (
        EApp (EApp (EVar "doTwice") (EVar "add10")) (ENum 100)
      )
    )
  )


{-
let fac = \n -> n * fac (n - 1)
in
  fac 10
-}
exp10 :: Expr
exp10 =
  ELet "fac" (ELam "n" (
    EBin Mul (EVar "n") (EApp (EVar "fac") (EBin Sub (EVar "n") (ENum 1)))
  )) (
    EApp (EVar "fac") (ENum 10)
  )


-- >>> eval [] exp6
-- VInt 101

data Value
  = VInt Int
  | VFun Env Ident Expr     -- "closure"
  deriving (Show)

type Env = [(Ident, Value)]


-- >>> eval [("y", 10), ("x", 35)] expr
-- 370

-- y * (x + 2)
expr :: Expr
expr = EBin Mul (EVar "y") (EBin Add (EVar "x") (ENum 2))

-- >>> eval [("x", 1000), ("y", 100000)] exp1
-- 129

{-


eval env exp

eval env exp0     -- env can be ANYTHING




exp0 =
  let x = 10
  in
    let y = 20
    in
      x + y


eval env exp1   --- as long as z is in the ENV

-- z is 'free'
exp1 =
  let x = 10
  in
    let y = 20
    in
      x + z

eval env exp2   --- z, x

exp2 =           -- z, x
  (let x = 10
  in
    let y = 20
    in
      x + z
  )
  +
  (
  let z = 100
  in
    x + z
  )

free :: Expr -> [Ident]


-}


-- let x = 0 in let y = 100 in x + y
exp1 :: Expr
exp1 =
  ELet "x" (ENum 29) (
    ELet "y" (ENum 100) (
      EBin Add (EVar "x") (EVar "y")
    )
  )


evalOp :: Op -> Value -> Value -> Value
evalOp Add (VInt n1) (VInt n2) = VInt (n1 + n2)
evalOp Sub (VInt n1) (VInt n2) = VInt (n1 - n2)
evalOp Mul (VInt n1) (VInt n2) = VInt (n1 * n2)
evalOp Div (VInt n1) (VInt n2) = VInt (n1 `div` n2)
evalOp _ _ _ = error "OOPS, op on non-int"

eval :: Env -> Expr -> Value
eval env (ENum n)        = VInt n
eval env (EBin op e1 e2) = evalOp op (eval env e1) (eval env e2)
eval env (EVar x)        = lookup x env
eval env (ELet x e1 e2)  = let v1   = eval env e1
                               msg  = printf "TRACE: eval-let %s = %s" x (show v1)
                               env' = (trace msg (x, v1))  : env
                           in
                              eval env' e2

eval env (ELam x body) = VFun env x body

eval env (EApp e1 e2)  = case (eval env e1, eval env e2) of
                           (VFun frozEnv x body, v2) -> eval ((x,v2):frozEnv) body
                           _ -> error "Oh no App with non-function"




check :: [Ident] -> Expr -> Bool
check env (ENum n)        = True
check env (EBin op e1 e2) = check env e1 && check env e2
check env (EVar x)        = checkEnv x env
check env (ELet x e1 e2)  = check env e1 && check (x:env) e2

checkEnv :: Ident -> [Ident] -> Bool
checkEnv x [] = False
checkEnv x (key: rest) =  x == key || checkEnv x rest


lookup :: Ident -> Env -> Value
lookup x [] = error ("oh no!!!! " ++ x ++ " is undefined!!!")
lookup x ((key, val):rest) = if x == key then val else lookup x rest


{-
              --- ENV
let x = e1
in            --- (x, v1):ENV         where v1 = eval ENV e1
  e2


 -}


-- >>> eval [] "let x = 5000 in x + 10"
-- 5101

funkyExp :: Expr
funkyExp =                                -- []
  ELet "x" (ENum 5000) (
    EBin Add                                -- [x = 5000]
    (
      ELet "x" (ENum 100) (
                                              -- [x = 100, x=5000]
        EBin Add (EVar "x") (ENum 1)
      )
    )                                      -- [x = 5000]
    (EVar "x")
  )

-- >>> funky
-- 5101

funky :: Int
funky =
  let x = 5000
  in
    (
      let x = 100
      in
        x + 1
    )
    +
    x
