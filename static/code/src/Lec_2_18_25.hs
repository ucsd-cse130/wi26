{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}
{-# HLINT ignore "Use uncurry" #-}
{-# HLINT ignore "Use foldr" #-}
{-# LANGUAGE DeriveFunctor #-}

module Lec_2_18_25  where

import Prelude hiding (filter)
import Data.Char

-- >>> evens []
-- []

-- >>> evens [1,2,3,4,7,8,45]
-- [2,4,8]

evens :: [Int] -> [Int]
evens []      = []
evens (x:xs)
  | even x    = x : evens xs
  | otherwise =     evens xs


-- >>> fourLetterWords ["i", "am", "very", "very", "very", "hungry"]
-- ["very", "very", "very"]

fourLetterWords :: [String] -> [String]
fourLetterWords []     = []
fourLetterWords (x:xs)
  | length x == 4      = x : fourLetterWords xs
  | otherwise          =     fourLetterWords xs

filter :: (a -> Bool) -> [a] -> [a]
filter cond []       = []
filter cond (x:xs)
  | cond x        = x : filter cond xs
  | otherwise     =     filter cond xs

evens' :: [Int] -> [Int]
evens' = filter (\x -> even x)

fourChars' :: [String] -> [String]
fourChars' = filter (\x -> length x == 4)

{-
foo []            = []
foo (x:xs)
  | even x        = x : foo xs
  | otherwise     =     foo xs

foo []            = []
foo (x:xs)
  | length x == 4 = x : foo xs
  | otherwise     =     foo xs

-}

-- >>> shout []
-- ""

-- >>> shout ['c', 'a', 't']
-- "CAT"

-- >>> shout "hello!"
-- "HELLO!"

-- >>> firstDigits ["1", "22", "333", "4444"]
-- [1,2,3,4]



shout :: String -> String
shout []     = []
shout (c:cs) = Data.Char.toUpper c : shout cs

squares :: [Int] -> [Int]
squares [] = []
squares (x:xs) = x * x : squares xs


firstDigits :: [String] -> [Int]
firstDigits []     = []
firstDigits (x:xs) = firstDigit x : firstDigits xs

{-

bob []     = []
bob (x:xs) = toUpper x : bob xs

bob []     = []
bob (x:xs) = x * x : bob xs

bob []     = []
bob (x:xs) = firstDigit x : bob xs

-}
bob :: (a -> b) -> [a] -> [b]
-- bob op []     = []
-- bob op (x:xs) = op x : bob op xs

bob = \op -> \xs -> case xs of
                      [] -> []
                      x:xs -> op x : bob op xs


firstDigits' :: [String] -> [Int]
firstDigits' xs = bob firstDigit xs

squares' :: [Int] -> [Int]
squares' xs = bob (\x -> x * x) xs

shout' :: String -> String
shout' xs = bob toUpper xs

inc :: Int -> Int
inc z = z + 1

stink :: Int -> Int
stink = inc

-- >>> firstDigits' ["1", "22", "333"]
-- [1,2,3]




firstDigit :: [Char] -> Int
firstDigit (c:_) = digitToInt c


combiner :: Int -> Int -> Int
combiner = \x1 -> (\x2 -> x1 + x2)

-- funky = (\x2 -> 10 + x2)
funky = combiner 10

-- bluug = ( 10 + 20) = 30
bluug = funky 20

-- >>> bluug
-- 30


-- >>> quiz
-- [3,5]

-- >>> cat' ["carne", "asada", "torta"]
-- "carneasadatorta"

quiz :: [Integer]
quiz = map (\(x, y) -> x + y) [(1,2),(2,3)]


len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len xs

tot :: [Int] -> Int
tot [] = 0
tot (x:xs) = x + tot xs

cat :: [String] -> String
cat [] = ""
cat (x:xs) = x ++ cat xs

tot' = foldR (\x res -> x + res) 0
cat' = foldR (\x res -> x ++ res) ""


foldR :: (a -> b -> b) -> b -> [a] -> b
foldR op b []     = b
foldR op b (x:xs) = op x (foldR op b xs)



{-

foldR op b []     = b
foldR op b (x:xs) = op x (foldR op b xs)

foldR :: (T3 -> Tb -> Tb) -> Tb -> [T3] -> Tb

foldR :: (a -> b -> b) -> b -> [a] -> b

    x :: T3
   xs :: [T3]
  T_op:: T3 -> T_b -> T_b


-- tod
foo []     = 0
foo (x:xs) = x + foo xs

foo []     = ""
foo (x:xs) = x ++ foo xs


len []     = 0
len (x:xs) = 1 + len xs

-}


len' :: [a] -> Int
len' = collapse (\_ res -> 1 + res) 0

-- >>> len' [1,2,3,4,4,5,6,7,7,8,01]
-- 11


collapse op b []     = b
collapse op b (x:xs) = x `op` collapse op b xs

{-
foo op b (x1:x2: x3: x4: x5:[])
==>
x1 `op` foo op b (x2:x3:x4:x5:[])
==>
x1 `op` (x2 `op` foo op b (x3:x4:x5:[]))
==>
x1 `op` (x2 `op` (x3 `op` foo op b (x4:x5:[])))
==>
x1 `op` (x2 `op` (x3 `op` (x4 `op` foo op b (x5:[]))))
==>
x1 `op` (x2 `op` (x3 `op` (x4 `op` (x5 `op` foo op b []))))
==>
x1 `op` (x2 `op` (x3 `op` (x4 `op` (x5 `op` b))))

replace `op` with `+`, `b` with `0`
==>
x1 + (x2 + (x3 + (x4 + (x5 + 0))))


replace `op` with `++`, `b` with `""`
==>
x1 ++ (x2 ++ (x3 ++ (x4 ++ (x5 ++ ""))))


tot' xs = collapse (+) 0  xs

cat' xs = collapse (++) "" xs


-}


bloop = (+)

-- >>> bloop 10 20
-- 30

{-

catTR ["carne", "asada", "burrito"]

loop "" ["carne", "asada", "burrito"]
==>
loop ("" ++ "carne") ["asada", "burrito"]
==>
loop ("" ++ "carne" ++ "asada" ["burrito"]
==>
loop ("" ++ "carne" ++ "asada" ++ "burrito") []
==>
("" ++ "carne" ++ "asada" ++ "burrito")




loop 0 (1:2:3:4:[])
==>
loop (0+1) (2:3:4:[])
loop (0+1+2) (3:4:[])
loop (0+1+2+3) (4:[])
loop (0+1+2+3+4) ([])
(0+1+2+3+4)


not-tail-recursive

tot (1:2:3:4:[])
==>
<1 + (tot (2:3:4:[])) >
==>
<1 + < 2 + tot (3:4:[]))> >
==>
<1 + < 2 + <3 + tot (4:[])> > >
==>
<1 + < 2 + <3 + <4 + (tot []) > > > >

<1 + < 2 + <3 + <4 + 0 > > > >

-}



-- >>> catTR ["carne", "asada", "torta"]
-- "carneasadatorta"


-- >>> totTR [10, 20, 30]
-- 60

{-
foo = loop 0
  where
    loop acc []     = acc
    loop acc (x:xs) = loop (acc + x)  xs

foo = loop ""
  where
    loop acc []     = acc
    loop acc (x:xs) = loop (acc ++ x) xs

totTR = foo (+) 0
catTR = foo (++) ""

foo op b = loop b
  where
    loop acc []     = acc
    loop acc (x:xs) = loop (op acc x) xs


-}
-- acc := Int , x := Int, op :: Int -> Int -> Int
-- >>> foldL (+) 0 [10,20,30]
-- 60

-- acc := String, x := String, op :: String -> String -> String
-- >>> foldL (++) "" ["10", "carne", "this is a string"]
-- "10carnethis is a string"

-- acc := [Int], x := Int, op :: [Int] -> Int -> [Int]
-- >>> foldL (\xs x -> x : xs) [] (1:2:3:[])
-- [3,2,1]

-- implement `map` , `filter` etc. using `foldl`

foldL :: (acc -> x -> acc) -> acc -> [x] -> acc
foldL op b = loop b
  where
    loop acc []     = acc
    loop acc (x:xs) = loop (op acc x) xs

{-




foldL op b (x1: x2: x3: x4:[])
==>
loop b (x1: x2: x3: x4:[])
==>
loop (op b x1) (x2: x3: x4:[])
==>
loop (op (op b x1) x2) (x3: x4:[])
==>
loop (op (op (op b x1) x2) x3) (x4:[])
==>
loop (op (op (op (op b x1) x2) x3) x4) ([])
==>
((((b `op` x1) `op` x2) `op` x3) `op` x4)





foldL (\xs x -> x : xs) [] (1:2:3:[])
==>
loop [] (1:2:3:[])                  <<< we know:  op =  (\xs x -> x : xs) >>>
==>
loop (op [] 1) (2:3:[])
==>
loop ((\xs x -> x : xs) [] 1) (2:3:[])
==>
loop ((1 : [])) (2:3:[])
==>
loop (2:(1 : [])) (3:[])
==>
loop (3:2:(1 : [])) ([])
==>
(3:2:(1:[]))



-}



-- totTR [] = 0
-- totTR (x:xs) = x + tot xs

-- catTR :: [String] -> String
-- -- catTR [] = ""
-- -- catTR (x:xs) = x ++ catTR xs


data Tree a
  = Leaf
  | Node a (Tree a) (Tree a)
  deriving (Functor, Show)

tree0 = Node "cat"
          (Node "mouse" Leaf Leaf)
          (Node "giraffe" Leaf Leaf)

tree1 = Node 3
          (Node 5 Leaf Leaf)
          (Node 7 Leaf Leaf)

-- >>> fmap length tree0
-- Node 3 (Node 5 Leaf Leaf) (Node 7 Leaf Leaf)

treeSize :: Tree String -> Tree Int
treeSize Leaf = Leaf
treeSize (Node v l r) = Node (length v) (treeSize l) (treeSize r)


-----

type Value = Int

type Id    = String

data Bin = Add | Sub | Mul
  deriving (Show)

data Expr
  = ENum Int
  | EBin Bin Expr Expr
  | EVar Id
  deriving (Show)

-- (4 + 12) - 5

e0 :: Expr
e0 = EBin Sub (EBin Add (ENum 4) (ENum 12)) (ENum 5)

-- >>> eval e0
-- 11

eval :: Expr -> Value
eval (ENum n)       = n
eval (EBin o e1 e2) = evalOp o (eval e1) (eval e2)
eval (EVar x)       = undefined


evalOp :: Bin -> Value -> Value -> Value
evalOp Add n1 n2 = n1 + n2
evalOp Sub n1 n2 = n1 - n2
evalOp Mul n1 n2 = n1 * n2
