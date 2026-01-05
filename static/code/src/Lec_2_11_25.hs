{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}

module Lec_2_11_25  where
import Prelude hiding (filter)
import Debug.Trace

sumTo :: Int -> Int
sumTo 0 = 0
sumTo n = n + sumTo (n-1)


sumTo' :: Int -> Int
sumTo' n = loop 0 n
  where
  loop acc i
    | i > 0     = loop (acc+i) (i-1)
    | otherwise = acc

{-
sumTo' 5
==>
< loop 0 5 >
==>
< < loop (0+5) 4 > >
==>
< < < loop (5+4) 3>  > >
==>
< < < < loop (9+3) 2 > > >
==>
< < < < < loop (12+2) 1 > > >
==>
< < < < < < loop (14+1) 0 > > >
==>
< < < < < < 15 > > > > >
==> ...
15

-}



{-
def sumTo(n):
    res = 0
    i = n
    while i > 0:
        res = res + i
        i   = i   - 1
    return res
-}


{-
sumTo 4
==>
< 4 + sumTo 3 >
==>
< 4 + < 3 + sumTo 2 > >
==>
< 4 + < 3 + < 2 + sumTo 1 > > >
==>
< 4 + < 3 + < 2 + < 1 + sumTo 0 > > > >
==>
< 4 + < 3 + < 2 + < 1 + 0 > > > >
==>
< 4 + < 3 + < 2 + 1 > > >
==>
< 4 + < 3 + 3 > >
==>
< 4 + 6 >
==>
10

-}


{-
len myList0
==>
< len (Cons 10 (Cons 20 (Cons 30 (Cons 40 Nil)))) >
==>
< 1 + < len (Cons 20 (Cons 30 (Cons 40 Nil))) > >
==>
< 1 + < 1 + < len (Cons 30 (Cons 40 Nil)) > > >
==>
< 1 + < 1 + < 1 + < len (Cons 40 Nil) > > > >
==>
< 1 + < 1 + < 1 + < 1 + < len Nil > > > > >
==>
< 1 + < 1 + < 1 + < 1 + 0 > > > >
==>
< 1 + < 1 + < 1 + 1 > > >
==>
< 1 + < 1 + 2 > >
==>
< 1 + 3 > >
==>
4
-}

data Tree a
    = Leaf
    | Node a (Tree a) (Tree a)
    deriving (Show)

myTree :: Tree Int
myTree = Node 2
            (Node 1 Leaf Leaf)
            (Node 3 Leaf Leaf)

nodes :: Tree a -> Int
nodes t = case t of
            Leaf       -> 0
            Node _ l r -> 1 + nodes l + nodes r


data LTree
    = LLeaf Int
    | LNode LTree LTree
    deriving (Show)


-- >>> sumLTree myLTree0
-- 15

sumLTree :: LTree -> Int
sumLTree (LLeaf n)   = n
sumLTree (LNode l r) = sumLTree l + sumLTree r

{-
sumLTree myLTree0
==>
sumLTree (LNode (LNode (LLeaf 1) (LLeaf 2)) (LLeaf 3))
==>
sumLTree (LNode (LLeaf 1) (LLeaf 2))    + sumLTree (LLeaf 3)
==>
sumLTree (LLeaf 1) + sumLTree (LLeaf 2) + sumLTree (LLeaf 3)
==>
1 + 2 + 3
==>
6
-}

-- >>> sumLTree myLTree0

myLTree0 = LNode (LNode (LLeaf 1) (LLeaf 2)) (LLeaf 3)

myLTree :: LTree
myLTree =
 LNode
   (LNode
       (LNode
           (LLeaf 1) (LLeaf 2))
       (LLeaf 3))
   (LNode
       (LLeaf 4) (LLeaf 5))


fac :: Int -> Int
fac n
  | n <= 1 = 1
  | otherwise = n * fac (n-1)

-- >>> fac' 5
-- 120

fac' :: Int -> Int
fac' n = loop 1 n
  where
    loop acc m = if trace ("TRACE: m = " ++ show m) m == 0 then acc else loop (acc*m) (m-1)
    -- loop acc 0 = acc
    -- loop acc m = loop (acc*m) (n-1)

foo = trace

{-
fac 5
==>
loop 1 5
==>
loop 1*5 4
==>
loop 1*5*4 3
==>
loop 1*5*4*3 2
==>
loop 1*5*4*3*2 1
==>
loop 1*5*4*3*2*1 0

-}

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


{-
foo []            = []
foo (x:xs)
  | even x        = x : foo xs
  | otherwise     =     foo xs

foo []            = []
foo (x:xs)
  | length x == 4 = x : foo xs
  | otherwise     =     foo xs

foo cond []            = []
foo cond (x:xs)
  | cond x        = x : foo cond xs
  | otherwise     =     foo cond xs

-}

filter cond []       = []
filter cond (x:xs)
  | cond x        = x : filter cond xs
  | otherwise     =     filter cond xs

evens' :: [Int] -> [Int]
evens'       = filter (\x -> even x)

fourLetters' :: [String] -> [String]
fourLetters' = filter (\x -> length x == 4)
