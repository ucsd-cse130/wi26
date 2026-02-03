{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{- HLINT ignore "Use foldr" -}
{- HLINT ignore "Use list literal" -}
{- HLINT ignore "Redundant lambda" -}
{- HLINT ignore "Use lambda" -}
module Lec_1_29_2026 where

import Prelude hiding (take)
import Data.Foldable (for_)
-- >>> 2 + 3
-- 5

inc :: Int -> Int
inc n = n + 1

list0 :: [Int]
list0 = [10, 20, 30, 40]

list1 :: [Int]
list1 = 10 : (20 : (30 : (40 : [])))

pair :: (Int, String)
pair = (10, "burrito")

fstPair :: (a, b) -> a
fstPair (x1, x2) = x1

sndPair :: (a, b) -> b
sndPair (x1, x2) = x2


-- >>> fstPair pair
-- 10

-- >>> sndPair pair
-- "burrito"

-- >>> firstElem 0 []
-- 0

-- >>> firstElem "" []
-- ""

firstElem :: a -> [a] -> a
firstElem d (x : rest) = x
firstElem d []         = d

add3 :: [Int] -> Int
add3 l = case l of
            (x1:x2:x3:rest) -> x1 + x2 + x3
            _ -> 0

{-
case l of
  (x1:rest) ->
    case rest of
        x2:rest2 -> case rest2 of
            x3:rest -> x1 + x2 + x3
  _ -> 0


-}

mystery :: [a] -> Int
mystery []     = 0
mystery (x:xs) = 1 + mystery xs


-- mystery (10 : 20 : 30 : [])
-- == 1 + mystery (20 : 30 : [])
-- == 1 + (1 + (mystery (30 : [])))
-- == 1 + (1 + (1 + mystery ([])))
-- == 1 + (1 + (1 + 0))
-- == 3


-- >>> take 5 []
-- []


-- >>> list0 == list1
-- True

take :: Int -> [a] -> [a]
take 0 _        = []
take _ []       = []
take n (x:rest) = x: take (n-1) rest

{-
take :: Int -> [a] -> [a]
take n []       = []
take n (x:rest) = if n == 0 then [] else x: take (n-1) rest
-}

-- take 1 (x:rest)  = x: (take 0 rest)
-- take 2 (x:rest)  = x: (take 1 rest)
-- take 3 (x:rest)  = x: (take 2 rest)

-- >>> take 0 ["cat", "dog", "mouse", "zebra"]
-- []

-- >>> take 3 ["cat", "dog", "mouse"]
-- ["cat", "dog", "mouse"]

-- >>> take 4 ["cat", "dog", "mouse"]
-- ["cat", "dog", "mouse"]

data Date = MkDate { day :: Int, month :: Int, year :: Int }

deadDate :: Date
deadDate = MkDate { month=1, day=2, year=2026 }

-- >>> year deadDate
-- 2026

-- extend :: Date -> Date
-- extend d = MkDate { month= month d , day= 1 + day d, year = year d}
extend (MkDate d m y) = MkDate (d+1) m y


extendDateBAD :: (Int, Int, Int) -> (Int, Int, Int)
extendDateBAD (m, d, y) = (m, d + 1, y)


{-
class Date {
  int day;
  int month;
  int year;
}

class Time {
  int hour;
  int min;
  int sec;
}
-}



deadTime :: (Int, Int, Int)
deadTime = (23, 59, 59)

-- >>> extendDate deadTime
-- (23,60,59)


data Para
    = PText String
    | PHead Int String
    | PList Bool [String]
    deriving (Show)




doc :: [Para]
doc = [para1, para2, para3]

para1 :: Para
para1 = PHead 1 "Notes from CSE 130"

para2 :: Para
para2 = PText "There are two types of languages"


funny n = n : funny (n+1)

-- >>> take 2 (funny 9)
-- >>> take 2 (9 : funny 10)
-- >>> 9 : take 1 (funny 10)
-- >>> 9 : take 1 (10 : funny 11)
-- >>> 9 : take 1 (10 : funny 11)
--     9 : 10 : take 0 (funny 11)
--     9 : 10 : []

-- [9,10]

-- >>> q6

-- q6 = case para2 of
--         PText s     -> s
--         PHead lvl _ -> lvl
--         PList ord _ -> ord


para3 :: Para
para3 = PList True
            [ "those that people complain about",
            "those that no one uses"]
