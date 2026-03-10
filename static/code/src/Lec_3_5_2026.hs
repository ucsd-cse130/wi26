{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverlappingInstances #-}
{-# LANGUAGE DeriveFunctor #-}

module Lec_3_5_2026 where

import Text.Printf (printf)


inc :: Int -> Int
inc n = n + 1


foo :: Int -> Bool
foo n = n > 10

bar :: String -> String
bar x = x ++ "dog" ++ x

plus :: a -> a -> a
plus = undefined

baz = plus foo foo

-- bob :: Int -> Double -> Double
-- bob x y = x + y

instance Num Bool where
    (+) b1 b2 = b1 || b2


data Day = Mon | Tue | Wed
  deriving(Eq, Show)


-- instance Show Day where
--     show Mon = "Monday"
--     show Tue = "Tuesday"
--     show Wed = "Wednesday"

dayInt :: Day -> Int
dayInt Mon = 0
dayInt Tue = 1
dayInt Wed = 2

instance Ord Day where
    (<=) d1 d2 = dayInt d1 <= dayInt d2

-- instance Eq Day where
--     (==) Mon Mon = True
--     (==) Tue Tue = True
--     (==) Wed Wed = True
--     (==) _   _   = False

data Env k v
    = Def v
    | Bind k v (Env k v)
    deriving (Show)

-- >>> keys env1
-- ["x", "y", "z"]

keys :: Env k v -> [k]
keys (Def v)         = []
keys (Bind k v rest) = k : keys rest


set :: (Ord k) => k -> v -> Env k v -> Env k v
set key val (Def v)
    = Bind key val (Def v)
set key val (Bind k v rest)
    | key < k   = Bind key val (Bind k v rest)
    | key == k  = Bind k   val rest
    | otherwise = Bind k   v   (set key val rest)

-- set "zebra" 99 (Bind "cat" 10 (Bind "dog"  20 (Bind "horse" 30 (Def 1000) ) )


-- >>> get "zebra" (set "zebra" 99 animals)
-- 99
-- >>> get "cat" (set "zebra" 99 animals)
-- 10
-- >>> get "dog" (set "zebra" 99 animals)
-- 20




animals :: Env String Int
animals =  Bind "cat" 10 (Bind "dog"  20 (Bind "horse" 30 (Def 1000) ) )

fastGet :: (Ord k) => v -> k -> Env k v -> v
fastGet def key (Def _)
                = def
fastGet def key (Bind k v rest)
    | key < k   = def
    | key == k  = v
    | otherwise = fastGet def key rest

-- get "armadillo"

-- >>> get "y" env1
-- 20
-- >>> get "x" env1
-- 10
-- >>> get "mickey" env1
-- 1000

get :: (Eq k) => k -> Env k v -> v
get key (Def v)         = v
get key (Bind k v rest) = if k == key then v else get key rest




-- "x" := 10, "y" := 20, "z" := 30, _ := 1000
env1 :: Env String Int
env1 = Bind "x" 10 (Bind "y" 20 (Bind "z" 30 (Def 1000)))


-- "y" := 20, "z" := 30, _ := 1000
env2 :: Env String Int
env2 = Bind "y" 20 (Bind "z" 30 (Def 1000))


-- "z" := 30, _ := 1000
env3 :: Env String Int
env3 = Bind "z" 30 (Def 1000)

--  _ := 1000
env4 :: Env String Int
env4 = Def 1000


-- "x" := 10, "y" := 20, "z" := 30, _ := 1000

---------

data Table' k v = MkTable' { def' :: v, bindings' :: [(k, v)] }
    deriving Show

data Table k v = MkTable v [(k, v)]
    deriving Show

def :: Table k v -> v
def (MkTable v _) = v

bindings :: Table k v -> [(k, v)]
bindings (MkTable _ bs) = bs



data Circle = MkCircle {x_coord :: Double, y_coord :: Double, radius :: Double }
    -- deriving(Show)

instance Show Circle where
    show (MkCircle x y r) = printf "( x = %f, y = %f, r = %f)" x y r

circ = MkCircle 0 0 100

areaCircle :: Circle -> Double
areaCircle c = pi * r * r
    where r = radius c

-- radius :: Circle -> Double
-- radius (MkCircle _ _ r) = r


data JVal
    = JStr String
    | JNum Double
    | JBool Bool
    | JObj [(String, JVal)]
    | JArr [JVal]
    deriving(Show)


keyVals = [("Mon", "Zanzibar"), ("Tue", "Fast"), ("Wed", "Flavorfull")]

names = [["alice", "bob", "charlie"], ["diana", "elephant"]]

scores :: [[Double]]
scores  = [[10, 20, 30], [50,60,70]]

sillyAdd :: (Num a) => a -> a -> a
sillyAdd x y = x + y

matrix = [[[1.0,2,3], [3,23,52], [1,123123]], [[1,2,3], [3,23,52], [1,123123]]]


instance (ToJVal a) => ToJVal [a] where
    toJVal xs = JArr (map toJVal xs)

instance (ToJVal a) => ToJVal [(String, a)] where
    toJVal kvs = JObj (map (\(k, v) -> (k, toJVal v)) kvs)

-- JObj [("mon", JNum 10), ("tue", JNum 20)]



class ToJVal a where
    toJVal :: a -> JVal


instance ToJVal Bool where
    toJVal b = JBool b

instance ToJVal Double where
    toJVal n = JNum n

instance ToJVal String where
    toJVal s = JStr s

----------------
data List a = Cons a (List a) | Nil
    deriving(Show, Functor)

l0 :: List Int
l0 = Cons 10 (Cons 20 (Cons 30 Nil))

mapList :: (a -> b) -> List a -> List b
mapList f Nil        = Nil
mapList f (Cons h t) = Cons (f h) (mapList f t)



data Tree a = Node a (Tree a) (Tree a) | Leaf
    deriving (Show, Functor)

t0 :: Tree Int
t0 = Node 2
        (Node 1 Leaf Leaf)
        (Node 3 Leaf Leaf)

showTree :: Tree Int -> Tree String
showTree Leaf = Leaf
showTree (Node x l r) = Node (show x) (showTree l) (showTree r)

tenTree :: Tree Int -> Tree Int
tenTree Leaf = Leaf
tenTree (Node x l r) = Node (x * 10) (tenTree l) (tenTree r)


mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f Leaf = Leaf
mapTree f (Node x l r) = Node (f x) (mapTree f l) (mapTree f r)


instance Mappable List where
    gmap = mapList

instance Mappable Tree where
    gmap = mapTree


{-

(a -> b) -> List a -> List b

(a -> b) -> Tree a -> Tree b

-}

class Mappable thing where
    gmap :: (a -> b) -> thing a -> thing b


{-
foo Leaf = Leaf
foo (Node x l r) = Node (show x) (foo l) (foo r)

foo Leaf = Leaf
foo (Node x l r) = Node (x * 10) (foo l) (foo r)

foo f Leaf = Leaf
foo f (Node x l r) = Node (f x) (foo f l) (foo f r)
-}

{-

foldr f b []     = []
foldr f b (x:xs) = f x (foldr f b xs)


x1: x2 x3: ... xn: []

x1 `f` (x2 `f` (x3 `f` ... (xn `f` b)))

\x y -> if f x then x : y else y

\x res -> f x : res

foldr ?? ?? [1,2,3,4,5,6]

1 `f` (2 `f` (3 `f` (4 `f` (5 `f` (6 `f` [])))
                                  [6]
                            [6]
                    [4, 6]
              [4, 6]
      [2,4,6]
[2,4,6]

-}