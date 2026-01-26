{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{- HLINT ignore "Redundant lambda" -}
{- HLINT ignore "Use lambda" -}
module Lec_1_20_2026 where

{-

MAGIC f = f (MAGIC f)

let FACSTEP =
    \rec -> \n -> ITE (ISZ n) ONE (MUL n (rec (DECR N)))

let FAC = MAGIC FACSTEP

MAGIC FACSTEP ZERO
==>
FACSTEP (MAGIC FACSTEP) ZERO
(1)==>
FACSTEP (MAGIC (MAGIC FACSTEP)) ZERO
==>
FACSTEP (MAGIC (MAGIC (MAGIC FACSTEP))) ZERO


FACSTEP (MAGIC FACSTEP) ZERO
(2)==>
ITE (ISZ ZERO) ONE (MUL ZERO (( MAGIC FACSTEP ) (DECR ZERO)))
==>
ONE

-}


-- pat = \x y z -> x * ( y + z )
pat x y z =  x * ( y + z )

-- >>> pat 31 42 56

ex1 :: Double
ex1 = 1 + 2

ex2 :: Double
ex2 = 2.0 + (3.6 * 9.1)

boo :: Bool
boo = True

bob :: Double
bob = if boo then ex1 else ex2


ex3 :: String
ex3 = "cat"
ex4 :: String
ex4 = "dog"

-- isPos (29 - 45)
-- isPos (-16)
-- (\n -> n > 0) (-16)
-- (-16 > 0)
-- False

isPos :: Int -> Bool
isPos n = n > 0


adder :: Int -> Int -> Int -> Int
adder x1 x2 x3 = x1 + x2 + x3


alice :: Int -> Int -> Int
alice = adder 10

charlie :: Int -> Int
charlie = alice 100

-- charlie 1000
-- ( alice 100) 1000
-- ( (adder 10) 100) 1000
-- 1110

-- >>> charlie 1000
-- 1110

-- >>> adder 10 20 30
-- 60




exInteger :: Integer
exInteger = 12

exInt :: Int
exInt = 12


{-

quiz :: ???
quiz = \x y -> x + y > 0


-}
-- >>> sumTo 0
-- 0
-- >>> sumTo 3
-- 6

sumTo :: Int -> Int
sumTo n
  | n == 0    = 0
  | otherwise = n + sumTo (n-1)

funkyTuple :: ( Char, Int -> Int , Double)
funkyTuple = ('c', sumTo, 3.4)

-- >>> getSnd ("cat", "dog", "nouse")
-- "dog"

identity :: a -> a
identity = \x -> x

-- getFst :: (a, b) -> a
getFst x = case x of
            (a1, _) -> a1

getSnd :: (a, b) -> b
getSnd x = case x of
            (_, a2) -> a2

-- >>> boolToString True
-- "TRUE"
-- >>> boolToString False
-- "FALSE"


-- boolToString :: Bool -> String
-- boolToString b
--   | b = "TRUE"
--   | otherwise = "FALSE"

boolToString :: Bool -> String
boolToString b = case b of
                    True -> "TRUE"
                    False -> "FALSE"

ints:: [Int]
ints = [1,2,2,3,4]

-- >>> 1 : (2 :( 3 : [] ))
-- [1,2,3]

-- >>> (1 : (2 : (3 : (4 : (5 : [])))))
-- [1,2,3,4,5]

ilistEmp :: [Int]
ilistEmp = []

ilist1 :: [Int]
ilist1 = 1 : ilistEmp

-- >>> copy3 "five"
-- ["five","five","five"]

-- >>> copy3 92
-- [92,92,92]
copy3 :: a -> [a]
copy3 x = [x, x, x]


-- >>> clone 0 "cat"
-- []

-- >>> clone 1 "cat"
-- ["cat"]

-- >>> clone 2 "cat"
-- ["cat","cat"]

-- >>> clone (-3) "cat"
-- ProgressCancelledException

clone :: Int -> a -> [a]
clone n x -- = if n <= 0 then [] else x : clone (n-1) x
  | n <= 0    = []
  | otherwise = x : clone (n-1) x
