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
filter cond (h:t) = let rest = filter cond t in
                    if cond h
                        then h : rest
                        else     rest

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





{-
addListTR [1,2,3,4,5]
=>
helper 0 [1,2,3,4,5]
helper (0 + 1) [2,3,4,5]
helper (0 + 1 + 2) [3,4,5]
helper (0 + 1 + 2 + 3) [4,5]
helper (0 + 1 + 2 + 3 + 4) [5]
helper (0 + 1 + 2 + 3 + 4 + 5) []
 (0 + 1 + 2 + 3 + 4 + 5)
 15
-}

-- >>> addListTR [1,2,3,4,5]
-- 15

splice :: [String]  -> String
splice []    = ""
splice (h:t) = h ++ splice t

-- >>> spliceTR ["cat", "dog", "mouse"]
-- "catdogmouse"

spliceTR :: [String] -> String
spliceTR = foldLeft (++) ""

addListTR :: [Int] -> Int
addListTR = foldLeft (+) 0

{-
foo list = helper "" list
  where
    helper ans []     = ans
    helper ans (x:xs) = let newAns = ans ++ x
                        in helper newAns xs

foo list = helper 0 list
  where
    helper ans []     = ans
    helper ans (x:xs) = let newAns = ans + x
                        in helper newAns xs

-}
foldLeft :: (t -> a -> t) -> t -> [a] -> t
foldLeft op b list = helper b list
  where
    helper ans []     = ans
    helper ans (x:xs) = let newAns = op ans x
                        in helper newAns xs

-- >>> listLength "I can"
-- 5

listLength xs = foldLeft (\ans _ -> ans + 1) 0 xs

{-
foldLeft :: (a -> b -> a) -> a -> [b] -> a
foldLeft op b list = helper b list
  where
    helper :: T_ans -> [T_stuff] -> T_ans
    helper ans []     = ans
    helper ans (x:xs) = helper (op ans x) xs

      -- op :: T_ans -> T_stuff -> T_ans
      -- x  :: T_stuff
      -- xs :: [T_stuff]

foldLeft op b [x1,x2,x3,x4]
=>
helper b [x1,x2,x3,x4]
=>
helper (b `op` x1) [x2, x3, x4]

helper ((b `op` x1) `op` x2) [x3, x4]

helper (((b `op` x1) `op` x2) `op` x3) [x4]

helper ((((b `op` x1) `op` x2) `op` x3) `op` x4) []

((((b `op` x1) `op` x2) `op` x3) `op` x4







spliceTR ["c", "d", "m"]
helper "" ["c", "d", "m"]
helper ("" ++"c") ["d", "m"]
helper ("" ++"c"++ "d") [ "m"]
helper ("" ++"c"++ "d" ++ "m") []
("" ++"c"++ "d" ++ "m")
"cdm"
-}

{-
len' :: [Int] -> Int
len'     = jef (\_ n -> 1 + n) 0

splice' :: [String] -> String
splice'  = jef (++) ""

addList' :: [Int] -> Int
addList' = jef (+)  0


foldr :: ( a -> b -> b ) -> b -> [a] -> b
foldr op b []    = b
foldr op b (h:t) = op h (foldr op b t)

    -- h :: T_stuff
    -- t :: [T_stuff]
-}

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

x1 `op` (x2 `op` (x3 `op` (x4 `op` b)))

x1 :    x2   :    x3 :      x4 :  []

-}



-- >>> splice ["cat", "dog", "tom"]
-- "catdogtom"


--------------------------------------
{-

op = (\xs x -> x : xs)

foldLeft (\xs x -> x : xs) [] [1,2,3]
=>

helper [] [1,2,3]
=>
helper [1] [2, 3]
=>
helper ([2, 1]) [3]
=>
helper ([3, 2, 1]) []
=>
[3,2,1]





-}

type Value = Int
type Ident = String
type Env   = [(Ident, Value)]

data Expr
  = ENum Int
  | EVar Ident
  | EAdd Expr Expr
  | ESub Expr Expr
  | EMul Expr Expr
  deriving (Show)



-- (2 + 3) * (7 - 1)
expr0 :: Expr
expr0 = EMul (EAdd (ENum 2) (ENum 3)) (ESub (ENum 7) (ENum 1))

-- >>> eval [("x", 10), ("y", 20)] expr1
-- 228

-- (2 + x) * (y - 1)
expr1 :: Expr
expr1 = EMul (EAdd (ENum 2) (EVar "x")) (ESub (EVar "y") (ENum 1))


eval :: Env -> Expr -> Value
eval _   (ENum n)     = n
eval env (EVar x)     = lookupVar env x
eval env (EAdd e1 e2) = eval env e1  + eval env e2
eval env (ESub e1 e2) = eval env e1  - eval env e2
eval env (EMul e1 e2) = eval env e1  * eval env e2

lookupVar :: Env -> Ident -> Value
lookupVar ((key,value):rest) x
  | x == key = value
  | otherwise = lookupVar rest x
lookupVar [] x = error ("OH GOD! no value for " ++ x)
