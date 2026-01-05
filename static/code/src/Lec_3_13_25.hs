{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use map" #-}
{-# LANGUAGE DeriveFunctor #-}
{-# HLINT ignore "Avoid lambda using `infix`" #-}
{-# LANGUAGE InstanceSigs #-}

module Lec_3_11_25 where

-- >>> :i Eq
-- type Eq :: * -> Constraint
-- class Eq a where
--   (==) :: a -> a -> Bool
--   (/=) :: a -> a -> Bool
--   {-# MINIMAL (==) | (/=) #-}
--   	-- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b) => Eq (Either a b)
--   -- Defined in ‘Data.Either’
-- instance Eq a => Eq (Maybe a) -- Defined in ‘GHC.Maybe’
-- instance Eq Integer -- Defined in ‘GHC.Num.Integer’
-- instance Eq a => Eq [a] -- Defined in ‘GHC.Classes’
-- instance Eq Word -- Defined in ‘GHC.Classes’
-- instance Eq a => Eq (Solo a) -- Defined in ‘GHC.Classes’
-- instance Eq Ordering -- Defined in ‘GHC.Classes’
-- instance Eq Int -- Defined in ‘GHC.Classes’
-- instance Eq Float -- Defined in ‘GHC.Classes’
-- instance Eq Double -- Defined in ‘GHC.Classes’
-- instance Eq Char -- Defined in ‘GHC.Classes’
-- instance Eq Bool -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--           Eq j, Eq k, Eq l, Eq m, Eq n, Eq o) =>
--          Eq (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--           Eq j, Eq k, Eq l, Eq m, Eq n) =>
--          Eq (a, b, c, d, e, f, g, h, i, j, k, l, m, n)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--           Eq j, Eq k, Eq l, Eq m) =>
--          Eq (a, b, c, d, e, f, g, h, i, j, k, l, m)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--           Eq j, Eq k, Eq l) =>
--          Eq (a, b, c, d, e, f, g, h, i, j, k, l)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--           Eq j, Eq k) =>
--          Eq (a, b, c, d, e, f, g, h, i, j, k)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--           Eq j) =>
--          Eq (a, b, c, d, e, f, g, h, i, j)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i) =>
--          Eq (a, b, c, d, e, f, g, h, i)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h) =>
--          Eq (a, b, c, d, e, f, g, h)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g) =>
--          Eq (a, b, c, d, e, f, g)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f) =>
--          Eq (a, b, c, d, e, f)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e) => Eq (a, b, c, d, e)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d) => Eq (a, b, c, d)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c) => Eq (a, b, c)
--   -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b) => Eq (a, b) -- Defined in ‘GHC.Classes’
-- instance Eq () -- Defined in ‘GHC.Classes’


-- >>> :i Num
-- type Num :: * -> Constraint
-- class Num a where
--   (+) :: a -> a -> a
--   (-) :: a -> a -> a
--   (*) :: a -> a -> a
--   negate :: a -> a
--   abs :: a -> a
--   signum :: a -> a
--   fromInteger :: Integer -> a
--   {-# MINIMAL (+), (*), abs, signum, fromInteger, (negate | (-)) #-}
--   	-- Defined in ‘GHC.Num’
-- instance Num Word -- Defined in ‘GHC.Num’
-- instance Num Integer -- Defined in ‘GHC.Num’
-- instance Num Int -- Defined in ‘GHC.Num’
-- instance Num Float -- Defined in ‘GHC.Float’
-- instance Num Double -- Defined in ‘GHC.Float’


-- >>> 2 + 2
-- 4

-- >>> xTenIfy [1,2,3,4]

-- >>> xTenIfy tree0


-- >>> stringIfy tree0
-- MyNode "5" (MyNode "2" (MyNode "1" MyLeaf MyLeaf) (MyNode "3" MyLeaf MyLeaf)) (MyNode "7" (MyNode "6" MyLeaf MyLeaf) (MyNode "8" MyLeaf MyLeaf))

-- >>> stringIfy [1.2, 2.3, 3.3,4.5]
-- ["1.2","2.3","3.3","4.5"]

-- stringIfy :: MyTree Int -> MyTree String
-- stringIfy :: [Int] -> [String]
stringIfy :: (Mappable c, Show a) => c a -> c String
stringIfy = mymap show

-- xTenIfy :: [Int] -> [Int]
-- xTenIfy :: MyTree Int -> MyTree Int
xTenIfy :: Mappable collection => collection Int -> collection Int
xTenIfy = mymap (* 10)



class Mappable collection where
  mymap :: (a -> b) -> collection a -> collection b




instance Mappable [] where
  mymap :: (a -> b) -> [a] -> [b]
  mymap f [] = []
  mymap f (x:xs) = f x : mymap f xs

instance Mappable MyTree where
  mymap :: (a -> b) -> MyTree a -> MyTree b
  mymap f MyLeaf         = MyLeaf
  mymap f (MyNode x l r) = MyNode (f x) (mymap f l) (mymap f r)



{-


mapList   :: (a -> b) -> List a   -> List   b
mapMyTree :: (a -> b) -> MyTree a -> MyTree b







**Ex 1**

intAdd :: Int -> Int -> Int
doubleAdd :: Double -> Double -> Double

class Num a where
  (+) :: a -> a -> a

intLess :: Int -> Int -> Bool
doubleLess :: Double -> Double -> Bool

class Ord a where
  (<) :: a -> a -> Bool

instance Ord Int where
  (<) = intLess

instance Ord Double where
  (<) = doubleLess



-}


-- >>> :i Functor
-- type Functor :: (* -> *) -> Constraint
-- class Functor f where
--   fmap :: (a -> b) -> f a -> f b
--   (<$) :: a -> f b -> f a
--   {-# MINIMAL fmap #-}
--   	-- Defined in ‘GHC.Base’
-- instance [safe] Functor (Result e)
--   -- Defined at /Users/rjhala/teaching/130-wi25/static/code/src/Lec_3_11_25.hs:242:10
-- instance [safe] Functor MyTree
--   -- Defined at /Users/rjhala/teaching/130-wi25/static/code/src/Lec_3_11_25.hs:179:23
-- instance Functor (Either a) -- Defined in ‘Data.Either’
-- instance Functor [] -- Defined in ‘GHC.Base’
-- instance Functor Solo -- Defined in ‘GHC.Base’
-- instance Functor Maybe -- Defined in ‘GHC.Base’
-- instance Functor IO -- Defined in ‘GHC.Base’
-- instance Functor ((->) r) -- Defined in ‘GHC.Base’
-- instance Functor ((,,,) a b c) -- Defined in ‘GHC.Base’
-- instance Functor ((,,) a b) -- Defined in ‘GHC.Base’
-- instance Functor ((,) a) -- Defined in ‘GHC.Base’


data MyTree a = MyNode a (MyTree a) (MyTree a) | MyLeaf
  deriving (Show, Eq, Functor)

tree0  :: MyTree Int
tree0 = MyNode 5
          (MyNode 2
            (MyNode 1 MyLeaf MyLeaf)
            (MyNode 3 MyLeaf MyLeaf)
          )
          (MyNode 7
            (MyNode 6 MyLeaf MyLeaf)
            (MyNode 8 MyLeaf MyLeaf)
          )

-- >>> xTenTree tree0
-- MyNode 50 (MyNode 20 (MyNode 10 MyLeaf MyLeaf) (MyNode 30 MyLeaf MyLeaf)) (MyNode 70 (MyNode 60 MyLeaf MyLeaf) (MyNode 80 MyLeaf MyLeaf))

-- >>> fmap show tree0
-- MyNode "5" (MyNode "2" (MyNode "1" MyLeaf MyLeaf) (MyNode "3" MyLeaf MyLeaf)) (MyNode "7" (MyNode "6" MyLeaf MyLeaf) (MyNode "8" MyLeaf MyLeaf))

{-
foo MyLeaf         = MyLeaf
foo (MyNode x l r) = MyNode (x * 10) (foo l) (foo r)

foo MyLeaf         = MyLeaf
foo (MyNode x l r) = MyNode (show x) (foo l) (foo r)
-}




data Result a
  = Err String
  | Val a
  deriving (Eq, Ord, Show)

safeHead :: [a] -> Result a
safeHead []    = Err "empty list"
safeHead (x:_) = Val x

safeDiv :: Int -> Int -> Result Int
safeDiv n 0 = Err "div by zero!"
safeDiv n m = Val (n `div` m)

instance Functor Result where
  fmap :: (a -> b) -> Result a -> Result b
  fmap f r = case r of
                Err s -> Err s
                Val a -> Val (f a)

-- >>> fmap (* 10) (Val 199)
-- Val 1990

data Exp
  = Num Int
  | Add Exp Exp
  | Div Exp Exp
  deriving (Eq, Ord, Show)

ex0 :: Exp
ex0 = Div (Num 10) (Add (Num 2) (Num 3))

ex1 :: Exp
ex1 = Div (Num 20) (Add (Num 2) (Num (-2)))

-- >>> eval ex1
-- divide by zero

-- >>> 20 `div` (1 - 1)
-- divide by zero

-- >>> eval ex1
-- divide by zero

-- >>> eval' ex0
-- Val 2
-- >>> eval' ex1
-- Err "yikes DBZ: Add (Num 2) (Num (-2))"

eval :: Exp -> Int
eval (Num n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Div e1 e2) = eval e1 `div` eval e2


eval' :: Exp -> Result Int
eval' (Num n) =
  return n

eval' (Add e1 e2) = do
  n1 <- eval' e1
  n2 <- eval' e2
  return (n1 + n2)

eval' (Div e1 e2) = do
  n1 <- eval' e1
  n2 <- eval' e2
  if n2 == 0
    then Err ("yikes DBZ: " ++ show e2)
    else return (n1 `div` n2)


-- class Thenable t where
--   myThen :: t a -> (a -> t b) -> t b
--   myPure :: a -> t a

instance Monad Result where
  ( >>= ):: Result a -> (a -> Result b) -> Result b
  ( >>= ) res doStuff =
   case res of
     Err e -> Err e
     Val n -> doStuff n

  return :: a -> Result a
  return a = Val a



data List a = Nil | Cons a (List a)
  deriving (Eq, Ord, Functor, Show)

append :: List a -> List a -> List a
append Nil ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

instance Applicative List where

instance Monad List where
  (>>=):: List a -> (a -> List b) -> List b
  (>>=) xs f = case xs of
                 Nil       -> Nil
                 Cons x xs' -> append (f x) (xs' >>= f)

  return :: a -> List a
  return a = Cons a Nil

-- >>> list0
-- Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))

-- >>> blah
-- Cons (True,1) (Cons (True,2) (Cons (True,3) (Cons (True,4) (Cons (False,1) (Cons (False,2) (Cons (False,3) (Cons (False,4) Nil)))))))


list0 = Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))
list1 = Cons True (Cons False Nil)




blah :: List (Bool, Integer)
blah = do
  b <- list1
  x <- list0
  return (b, x)


instance Applicative Result where
{-

caseThen res1 doStuff1

case res1 of
  Err e  -> Err e
  Val n -> doStuffWith1 n


caseThen res2 doStuff2

case res2 of
  Err e -> Err e
  Val n -> doStuffWith2 n

caseThen res doStuff =
  case res of
    Err e -> Err e
    Val n -> doStuff n


blah >>= \x ->
  stuff

do
  x <- blah
  stuff




-}






















data Tree a = Node (Tree a) (Tree a) | Leaf a
    deriving (Show)





tree0' :: Tree Int
tree0' = Node (Node
                (Leaf 1)
                (Leaf 2)
             )
             (Node
                (Leaf 3)
                (Leaf 4)
             )
-- data Result e v
--   = Err e
--   | Val v
--   deriving (Show)


{-

class Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  return :: a -> m a

-}
