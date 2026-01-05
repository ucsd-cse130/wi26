module Lec_2_4_25  where

import Text.Printf

hello :: String
hello = "hello"

-- "Type alias" -- meaning you can write `Date` instead of `(Int, Int, Int)`
-- type Date = (Int, Int, Int)

-- type Time = (Int, Int, Int)

-- Create a new type for `Date`

{-
class Date {
    public int day;
    public int month;
    public int year;
}

Date deadline = new Date(2, 4, 2025);

deadline.year



-}

data Date = MkDate { month :: Int, day :: Int, year :: Int }

data Time = MkTime Int Int Int


getYear :: Date -> Int
getYear date = case date of
                 MkDate _ _ y -> y

getDay :: Date -> Int
getDay date = case date of
                 MkDate _ d _ -> d

getMonth :: Date -> Int
getMonth date = case date of
                 MkDate m _ _ -> m




deadlineDate :: Date
deadlineDate = MkDate 2 14 2025

deadlineYear :: Int
deadlineYear = year deadlineDate


deadlineTime :: Time
deadlineTime = MkTime 23 59 59

bumpDate :: Date -> Int -> Date
bumpDate date days = undefined

-- extendedDate :: Date
-- extendedDate = bumpDate deadlineTime 5

{-
# Notes from CSE 130

There are two kinds of languages

1. those that people complain about

2. those that no one uses

-}

data Para
    = PText String
    | PHead Int String
    | PList Bool [String]

blah :: Para
blah = PText "Hey there!"

doc :: [Para]
doc =
    [ PHead 1 "Notes from CSE 130"
    , PText "There are two kinds of languages"
    , PList True [ "those that people complain about", "those that noone uses"]
    ]

mkHtml :: [Para] -> String
mkHtml ps = case ps of
              []     -> ""
              p:rest -> paraHtml p ++ mkHtml rest

paraHtml :: Para -> String
paraHtml p = case p of
    PText str     -> printf "<p>%s</p>" str
    PHead lvl str -> printf "<h%d>%s</h%d>" lvl str lvl
    PList b items -> undefined


{-
(a) String (b) Bool (c) Int (d) Para (e) "Other"

quiz :: ???


type String = [Char]
-}



quiz :: Para -> Int
quiz p =
  case p of
    PText str       -> 0
    PHead _ str     -> 1
    PList b items   -> 2

-- bob n = if n > 0 then 10 else "cat"
bob n = case True of
            True -> 10
            False -> "cat"



paraHtml' :: Para -> String
paraHtml' (PText str    ) = printf "<p>%s</p>" str
paraHtml' (PHead lvl str) = printf "<h%d>%s</h%d>" lvl str lvl
paraHtml' (PList b items) = undefined

-- >>> paraHtml (PText "There are two kinds...")
-- "<p>There are two kinds...</p>"


-- >>> paraHtml (PHead 1 "Notes from CSE130")
-- "<h1>Notes from CSE130</h1>"



data Nat
    = Zero
    | Inc Nat

n0 :: Nat
n0 = Zero

n1 :: Nat
n1 = Inc Zero

n2 :: Nat
n2 = Inc ( Inc Zero)

n5 :: Nat
n5 = Inc ( Inc ( Inc ( Inc ( Inc Zero))))