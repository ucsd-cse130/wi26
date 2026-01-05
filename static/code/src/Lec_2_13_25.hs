{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}
{-# HLINT ignore "Use uncurry" #-}

module Lec_2_13_25  where

import Prelude hiding (filter)
import Debug.Trace
import Data.Char
import Data.Char (digitToInt)

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


{-

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


-}



tot' xs = collapse (+) 0  xs

cat' xs = collapse (++) "" xs

bloop = (+)

-- >>> bloop 10 20
-- 30
