{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{- HLINT ignore "Use foldr" -}
{- HLINT ignore "Use map" -}
{- HLINT ignore "Eta reduce" -}

module Lec_2_10_2026 where

import Text.Printf (printf)
import Prelude hiding (map, filter)
import Data.Char (toUpper)

data List t
    = IEmp
    | ICons t (List t)
    deriving (Show)

{-
data [t]
    = []
    | (:) t [t]

[1,2,3] ==> 1 : (2 : (3 : []))
        ==> ICons 1 (ICons 2 (ICons 3 IEmp))
-}

data SillyBilly a b c d
  = S Int
  | B Bool

junkVal :: SillyBilly a b c d
junkVal = S 29

bobobob :: [a]
bobobob = []

{-
data Tree a
  = Leaf | Node a ( Tree a) (Tree a)

foo :: Tree a
foo = Leaf

-}

list0 :: List Int
list0 = ICons 24 (ICons 56 (ICons 99 IEmp))

-- >>> insertLeft 10 list0
-- ICons 10 (ICons 24 (ICons 56 (ICons 99 IEmp)))

insertLeft :: t -> List t -> List t
insertLeft n l = ICons n l

-- >>> insertRight 10 (ICons 24 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (ICons 10 IEmp)))

-- insertRight 0 (ICons 24 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (insertRight 0 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (insertRight 0 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (insertRight 0 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (ICons 0 IEmp)))

insertRight :: a -> List a  -> List a
insertRight n IEmp        = ICons n IEmp
insertRight n (ICons h t) = ICons h (insertRight n t)


insertRight' :: a -> [a] -> [a]
insertRight' n []      =  [n]
insertRight' n (h : t) =  h : (insertRight' n t)

------------------------------------------------------------------------------------------------------------------------


fac :: Int -> Int
fac n
  | n <= 1 = 1
  | otherwise = n * fac (n-1)

facTR :: Int -> Int
facTR n = loop 1 n

loop :: Int -> Int -> Int
loop res n
  | 1 < n     = loop (res * n) (n - 1)
  | otherwise = res

{-

< facTR 5 >
=>
< loop 1 5 >
< loop 5 4 >
< loop 20 3 >
< loop 60 2 >
< loop 120 1>
< 120 >



def fac(n):
  res = 1
  while 1 < n:
    res = res * n
    n = n - 1
  return res

-}


------------------------------------------------------------------------------------------------------------------------


-- >>> evens' [0,1,2,3,4,5,6]
-- [0,2,4,6]

filter :: (a -> Bool) -> [a] -> [a]
filter cond []    = []
filter cond (h:t) = if cond h
                        then h : filter cond t
                        else     filter cond t

evens' :: [Int] -> [Int]
evens' = filter even

fourLetters' :: [String] -> [String]
fourLetters' = filter (\h -> length h == 4)

evens :: [Int] -> [Int]
evens []    = []
evens (h:t) = if even h
                then h : evens t
                else     evens t

fourLetters :: [String] -> [String]
fourLetters [] = []
fourLetters (h:t) = if length h == 4
                        then h : fourLetters t
                        else     fourLetters t

-- >>> fourLetters' ["dog", "coffee", "dogg", "word", "at"]
-- ["dogg","word"]


{-
tom []    = []
tom (h:t) = if even h
               then h : tom t
               else     tom t

tom []    = []
tom (h:t) = if length h == 4
               then h : tom t
               else     tom t

tom :: (a -> Bool) -> [a] -> [a]
h :: a
t :: [a]
-}


-- >>> shout ['w', 'h' , 'i', 's', 'p', 'e', 'r']
-- "WHISPER"

shout :: [Char] -> [Char]
shout []     = []
shout (x:xs) = toUpper x : shout xs

-- >>> replicate 5 '.'
-- "....."

dottify :: Int -> [Char]
dottify n = replicate n '.'

-- >>> dots [1,2,3]
-- [".","..","..."]

dots :: [Int] -> [String]
dots []    = []
dots (h:t) = dottify h : dots t

{-

bob []     = []
bob (x:xs) = toUpper x : bob xs

bob []    = []
bob (x:xs) = dottify x : bob xs

-}
map :: (a -> b) -> [a] -> [b]
map op []    = []
map op (x:xs) = op x : map op xs


-- >>> shout' ['w', 'h' , 'i', 's', 'p', 'e', 'r']
-- "WHISPER"


-- foo = \x y z -> e
-- (\x -> f x) =========== f

-- >>> map (\(x, y) -> x + y) [(1, 2) , (2, 3)]
-- [3,5]

shout' :: String -> String
shout' xs = map toUpper xs

dots' :: [Int] -> [String]
dots' xs = map dottify xs


-- >>> addList [1,2,3,4,5]
-- 15

-- >>> len [1,2,3,4,5]
-- 5

-- >>> len "tom"
-- 3

len :: [a] -> Int
len []    = 0
len (h:t) = 1 + len t

addList :: [Int] -> Int
addList []    = 0
addList (h:t) = h + addList t

splice :: [String]  -> String
splice []    = ""
splice (h:t) = h ++ splice t


{-

jef []    = 0
jef (h:t) = 1 + jef t

jef []    = 0
jef (h:t) = h + jef t

jef []    = ""
jef (h:t) = h ++ jef t

jef []    = 0
jef (h:t) = 1 + jef t

-}

len' :: [Int] -> Int
len'     = jef (\_ n -> 1 + n) 0

splice' :: [String] -> String
splice'  = jef (++) ""

addList' :: [Int] -> Int
addList' = jef (+)  0


jef op b []    = b
jef op b (h:t) = op h (jef op b t)

-- >>> 1 `plux` 20

plux a b = a + b


{-
jef op b [x1, x2, x3, x4]
==>
op x1 (jef op b [x2, x3, x4])
==>
op x1 (op x2 (jef op b [x3, x4]))
==>
op x1 (op x2 (op x3 (jef op b [x4])))
==>
op x1 (op x2 (op x3 (op x4 (jef op b []))))
==>
op x1 (op x2 (op x3 (op x4 b)))








-}



-- >>> splice ["cat", "dog", "tom"]
-- "catdogtom"


------------------------------------------------------------------------------------------------------------------------

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

para3 :: Para
para3 = PList True
            [ "those that people complain about",
            "those that no one uses"]

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
