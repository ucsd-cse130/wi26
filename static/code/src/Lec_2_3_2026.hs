{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{- HLINT ignore "Use foldr" -}
{- HLINT ignore "Use list literal" -}
{- HLINT ignore "Redundant lambda" -}
{- HLINT ignore "Use lambda" -}
module Lec_2_3_2026 where

import Text.Printf (printf)

data Para
    = PText String
    | PHead Int String
    | PList Bool [String]
    deriving (Show)

doc :: [Para]
doc = [para1, para2, para3]

-- >>> html doc
-- "<h1>Notes from CSE 130</h1><p>There are two types of languages</p><ol><li>those that people complain about</li><li>those that no one uses</li></ol>"


paraHtml :: Para -> String
paraHtml (PText s)         = printf "<p>%s</p>" s
paraHtml (PHead lvl s)     = printf "<h%d>%s</h%d>" lvl s lvl
paraHtml (PList ord items) = printf "<%s>%s</%s>" tag (itemsHtml items) tag
  where
    tag = if ord then "ol" else "ul"

cat :: [String] -> String
cat [] = ""
cat (s1:rest) = s1 ++ cat rest

html :: [Para] -> String
html []     = ""
html (p:ps) = paraHtml p ++ html ps

itemsHtml :: [String] -> String
itemsHtml []     = ""
itemsHtml (i:is) = itemHtml i ++ itemsHtml is

itemHtml :: String -> String
itemHtml i = printf "<li>%s</li>" i

-- >>> bloep 10 20
-- "10 horse 20"


bloep :: Int -> Int -> String
bloep a b = printf "%d %s %d" a "horse" b





para1 :: Para
para1 = PHead 1 "Notes from CSE 130"

para2 :: Para
para2 = PText "There are two types of languages"

para3 :: Para
para3 = PList True
            [ "those that people complain about",
            "those that no one uses"]


-- >>> quiz

-- >>> para2
-- PText "There are two types of languages"

-- quiz = case (PText "There are two types of languages") of
--         PText s     -> s            -- STRING
--         PHead lvl _ -> lvl          -- INT
--         PList ord _ -> ord          -- BOOL

{-
 if e1 then e2 else e3

 case e1 of
    True -> e2
    False -> e3
-}
-- >>> :info Bool
-- type Bool :: *
-- data Bool = False | True
--   	-- Defined in ‘GHC.Types’
-- instance Bounded Bool -- Defined in ‘GHC.Internal.Enum’
-- instance Enum Bool -- Defined in ‘GHC.Internal.Enum’
-- instance Show Bool -- Defined in ‘GHC.Internal.Show’
-- instance Eq Bool -- Defined in ‘GHC.Classes’
-- instance Ord Bool -- Defined in ‘GHC.Classes’
-- instance Read Bool -- Defined in ‘GHC.Internal.Read’

{-
data Bool = False | True

-}


-- >>> quiz2
-- 5

quiz2 :: Int
quiz2 = case PText "There are two types of languages" of
          PText _     -> 5
          PHead lvl _ -> lvl
          PList _ _   -> 6



data Nat
    = Zero
    | Next Nat
    deriving (Eq, Show)

{-
data List a
  = Nil
  | Cons a (List a)
  deriving (Show)
-}

-- >>> three
-- Next (Next (Next Zero))

zero = Zero
one  = Next Zero
two = Next one

three = Next two

-- >>> foo 3

-- foo 3
-- Next (foo 2)
-- Next (Next (foo 1))
-- Next (Next (Next (foo 0)))
-- Next (Next (Next (Zero)))

toNat :: Int -> Nat
toNat i = if i <= 0 then Zero else Next (toNat (i - 1))

-- >>> toInt one
-- 1

toInt :: Nat -> Int
toInt Zero   = 0
toInt (Next n') = 1 + toInt n'

add' :: Nat -> Nat -> Nat
add' n m = toNat (toInt n + toInt m)

sub' :: Nat -> Nat -> Nat
sub' n m = toNat (toInt n - toInt m)

-- >>> add two two
-- Next (Next (Next (Next Zero)))

add :: Nat -> Nat -> Nat
add Zero     m = m
add (Next n) m = Next (add n m)

-- add (Next n) m = add n (Next m)

-- >>> sub three one
-- Next (Next Zero)
sub :: Nat -> Nat -> Nat
sub n        Zero     = n
sub Zero     _        = Zero
sub (Next n) (Next m) = sub n m

--

-- add (Next (Next Zero)) m
-- ==> add (Next Zero) (Next m)
-- ==> add Zero (Next (Next m))
-- ==> Next (Next m)




-- (Next (Next m))


-- ==> Next (add (Next Zero) (Next (Next (Next Zero))))
-- ==> Next (Next (add Zero (Next (Next (Next Zero)))))
-- ==> Next (Next ((Next (Next (Next Zero)))))

-- toInt Zero      = 0
-- toInt (Next n') = 1 + toInt n'


    -- if n <= 0 then 0 else 1 + toInt (n-1)


{-
2.9

4.0 + 2.9

-}

data Exp
    = Num Double
    | Add Exp Exp
    | Sub Exp Exp
    | Mul Exp Exp
    deriving (Show)

-- (4.0 + 2.9) * (3.78 - 5.92)
exp0 :: Exp
exp0 = Mul
        (Add (Num 4.0 ) (Num 2.9))
        (Sub (Num 3.78) (Num 5.92))

-- >>> eval exp0
-- -14.766000000000002

eval :: Exp -> Double
eval (Num n    ) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Sub e1 e2) = eval e1 - eval e2
eval (Mul e1 e2) = eval e1 * eval e2

-- [1,2,3]
-- 1 : (2 : (3 : []))

list0 :: List Int
list0 = Cons 1 (Cons 2 (Cons 3 Nil))

data List a
  = Nil
  | Cons a (List a)
  deriving (Show)

-- >>> app (Cons 1 (Cons 2 Nil)) (Cons 3 (Cons 4 Nil))
-- >>> Cons 1 (app (Cons 2 Nil) (Cons 3 (Cons 4 Nil)))
-- >>> Cons 1 (Cons 2 (app Nil (Cons 3 (Cons 4 Nil))))
-- >>> Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))

-- (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil))))

append :: List a -> List a -> List a
append Nil         ys = ys
append (Cons x xs) ys = Cons x (append xs ys)