{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}

module Lec_2_6_25  where
import Prelude hiding (filter)
import Debug.Trace

data Nat
    = Null
    | Ink Nat
    deriving (Show)

n0 :: Nat
n0 = Null

n1 :: Nat
n1 = Ink Null

n2 :: Nat
n2 = Ink ( Ink Null)

n5 :: Nat
n5 = Ink ( Ink ( Ink ( Ink ( Ink Null))))

-- >>> toInt n5
-- 5

toInt :: Nat -> Int
toInt n = case n of
            Null -> 0
            Ink n' -> 1 + toInt n'

toInt' :: Nat -> Int
toInt' Null     = 0
toInt' (Ink n') = 1 + toInt n'

toNat :: Int -> Nat
toNat n = if n <= 0 then Null else Ink (toNat (n-1))

-- >>> foo 20
-- Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink (Ink Null)))))))))))))))))))

-- foo 2
-- Ink (foo 1)
-- Ink (Ink (foo 0))
-- Ink (Ink ( Null ))


-- (a) Null     (b) 0       (c) ?


-- toInt :: Nat -> Int
-- toInt n =


addAsInt :: Nat -> Nat -> Nat
addAsInt n m = toNat (toInt n + toInt m)

-- >>> add (Ink (Ink Null)) (Ink (Ink (Ink Null)))
-- Ink (Ink (Ink (Ink (Ink Null))))

{-
add (Ink (Ink Null)) (Ink (Ink (Ink Null)))
==>
add ((Ink Null)) (Ink (Ink (Ink (Ink Null))))
==>
add ((Null)) (Ink (Ink (Ink (Ink (Ink Null)))))
==>
(Ink (Ink (Ink (Ink (Ink Null)))))
-}

add1 :: Nat -> Nat -> Nat
add1 Null    m = m
add1 (Ink n) m = add1 n (Ink m)

add2 :: Nat -> Nat -> Nat
add2 Null    m = m
add2 (Ink n) m = Ink (add2 n m)

-- sub :: Nat -> Nat -> Nat
sub :: Nat -> Nat -> Nat
sub n    Null       = n
sub Null _          = Null
sub (Ink n) (Ink m) = sub n m


data Expr
    = ENum Double
    | EAdd Expr Expr
    | ESub Expr Expr
    | EMul Expr Expr

-- >>> ( 4.0 + 2.9 ) * (3.78 - 5.92)
-- -14.766000000000002

e0 :: Expr
e0 = EMul
        (EAdd (ENum 4.0) (ENum 2.9))
        (ESub (ENum 3.78) (ENum 5.92))

-- >>> eval e0
-- -14.766000000000002

eval :: Expr -> Double
eval e = case e of
            ENum n -> n
            EAdd e1 e2 -> eval e1 + eval e2
            ESub e1 e2 -> eval e1 - eval e2
            EMul e1 e2 -> eval e1 * eval e2


data List a
    = Nil
    | Cons a (List a)
    deriving (Show)

-- [1,2,3]        => (Cons 1 (Cons 2(Cons 3 Nil)))

-- >>> len (Cons "cat" (Cons "dog" (Cons "mouse" (Cons "zebra" Nil))))
-- 4

-- >>> append (Cons 1 (Cons 2 (Cons 3 Nil))) (Cons 10 (Cons 20 (Cons 30 Nil)))

-- (Cons 1 (Cons 2 (Cons 3 (Cons 10 (Cons 20 (Cons 30 Nil))))))

-- >>> sumTo 10
-- 55



{-
append (Cons 1 ) (Cons 10 (Cons 20 (Cons 30 Nil)))
==>
Cons 1 (append (Cons 2 (Cons 3 Nil)) (Cons 10 (Cons 20 (Cons 30 Nil))) )
==>
Cons 1 ((Cons 2 (append (Cons 3 Nil)) (Cons 10 (Cons 20 (Cons 30 Nil))) )
==>
Cons 1 ((Cons 2 ((Cons 3 (append Nil)) (Cons 10 (Cons 20 (Cons 30 Nil))) )
==>
Cons 1 ((Cons 2 ((Cons 3 (Cons 10 (Cons 20 (Cons 30 Nil)))

-}
append :: List a -> List a -> List a
append Nil          l2 = l2
append (Cons h1 t1) l2 = Cons h1 (append t1 l2)


-- >>> [1,2,3] ++ [10,20,30]
-- [1,2,3,10,20,30]
--

len :: List a -> Int
len Nil = 0
len (Cons _ t) = 1 + len t

{-
def len(l):
  acc = 0
  while (l == Cons h t):
    acc = acc + 1
    l   = t
  return acc


-}
len' :: List a -> Int
len' l = loop 0 l
  where
   loop acc Nil        = acc
   loop acc (Cons _ t) = loop (acc+1) t


myList0 :: List Int
myList0 = Cons 10 (Cons 20 (Cons 30 (Cons 40 Nil)))

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
