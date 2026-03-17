{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE DeriveFunctor #-}

module Lec_3_10_2026 where

import Text.Printf (printf)



instance Mappable Result where
    gmap f (Error msg) = Error msg
    gmap f (Value a)   = Value (f a)

data Option a = Some a          | Null
    deriving(Show)

instance Mappable Option where
    gmap f Null     = Null
    gmap f (Some a) = Some (f a)

data List a   = Cons a (List a) | Nil
    deriving(Show)

instance Functor List where
    fmap = gmap

instance Applicative List where


-- [a1, a2, a3, ...]
-- [b11, b12, b13...., b21, b22, b23..., b31, b32, b33...]
-- f :: a -> [b]

l99 :: List Int
l99 = Cons 1 (Cons 2 (Cons 3 Nil))

single x = Cons x Nil


-- >>> quiz
-- Cons (1,"cat") (Cons (1,"dog") (Cons (2,"cat") (Cons (2,"dog") (Cons (3,"cat") (Cons (3,"dog") Nil)))))

quiz = do
    x <- l99
    y <- animals
    single (x, y)

{-

    for x in l99
        for y in animals
            yield (x, y)
-}

quiz' =
    (>>=) l99 (\x ->
        single (x * 100)
    )

l1 :: List String
l1 = Cons "cat" (Cons "dog" Nil)

animals = Cons "cat" (Cons "dog" Nil)

-- >>> quiz
-- Cons 100 (Cons 200 (Cons 300 Nil))


instance Monad List where
    (>>=) Nil fa         = Nil
    (>>=) (Cons x xs) fa = append (fa x) ((>>=) xs fa)

append :: List a -> List a -> List a
append Nil ys         = ys
append (Cons x xs) ys = Cons x (append xs ys)

l0 :: List Int
l0 = Cons 10 (Cons 20 (Cons 30 Nil))

mapList :: (a -> b) -> List a -> List b
mapList f Nil        = Nil
mapList f (Cons h t) = Cons (f h) (mapList f t)



data Tree a = Node a (Tree a) (Tree a) | Leaf
    deriving (Show, Functor)

-- >>> t0
-- Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf)
-- >>> funny (* 100) t0
-- Node 200 (Node 100 Leaf Leaf) (Node 300 Leaf Leaf)

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

-- >>> l0
-- Cons 10 (Cons 20 (Cons 30 Nil))

-- >>> funny (+ 1) l0
-- Cons 11 (Cons 21 (Cons 31 Nil))

funny :: Mappable thing => (a -> b) -> thing a -> thing b
funny f x = gmap f x

{-

(a -> b) -> List a -> List b

(a -> b) -> Tree a -> Tree b

-}

class Mappable f where
    gmap :: (a -> b) -> f a -> f b

-- >>> :i Functor
-- type Functor :: (* -> *) -> Constraint
-- class Functor f where
--   fmap :: (a -> b) -> f a -> f b
--   (<$) :: a -> f b -> f a
--   {-# MINIMAL fmap #-}
--   	-- Defined in ‘GHC.Base’
-- instance [safe] Functor Tree
--   -- Defined at /Users/rjhala/teaching/130-wi26/static/code/src/Lec_3_10_2026.hs:36:21
-- instance [safe] Functor Result
--   -- Defined at /Users/rjhala/teaching/130-wi26/static/code/src/Lec_3_10_2026.hs:165:10
-- instance Functor ((,) a) -- Defined in ‘GHC.Base’
-- instance Functor ((,,) a b) -- Defined in ‘GHC.Base’
-- instance Functor ((,,,) a b c) -- Defined in ‘GHC.Base’
-- instance Functor ((,,,,) a b c d) -- Defined in ‘GHC.Base’
-- instance Functor ((,,,,,) a b c d e) -- Defined in ‘GHC.Base’
-- instance Functor ((,,,,,,) a b c d e f) -- Defined in ‘GHC.Base’
-- instance Functor ((->) r) -- Defined in ‘GHC.Base’
-- instance Functor IO -- Defined in ‘GHC.Base’
-- instance Functor [] -- Defined in ‘GHC.Base’
-- instance Functor Maybe -- Defined in ‘GHC.Base’
-- instance Functor Solo -- Defined in ‘GHC.Base’
-- instance Functor (Either a) -- Defined in ‘Data.Either’

---

data Exp
    = Num Int
    | Add Exp Exp
    | Div Exp Exp
    deriving (Show)

exp0 :: Exp
exp0 = Add (Num 3) (Num 5)

exp1 :: Exp
exp1 = Add (Num 2) (Num (-2))

exp2 :: Exp
exp2 = Div exp0 (Num 4)

exp3 :: Exp
exp3 = Div exp0 exp1

exp4 :: Exp
exp4 = Add (Num 67) exp3

-- >>> evalWithCatch exp0
-- 8

{-
eval exp3
==>
eval (Div exp0 exp1)

    let Value v1 = eval exp0
        Value v2 = eval exp1
    in
        case ...
==>
eval (Div exp0 exp1)

    let Value v1 = Value 8
        Value v2 = Value 0
    in
        case ...

==>

        case 0 of
           0 -> Error ("oh now....")

==> Error "oh no!"

-}

-- >>> eval exp0
-- >>> eval exp1
-- >>> eval exp2
-- >>> eval exp3
-- >>> eval exp4
-- Value 8
-- Value 0
-- Value 2
-- Error "oh no! DBZ thanks to Add (Num 2) (Num (-2))"
-- Error "oh no! DBZ thanks to Add (Num 2) (Num (-2))"


-- (a) Error "oh no! ..."
-- ()

data Result a = Value a | Error String
    deriving(Show)

{-

r :: Result ?a
v :: ?a

-}

{-

class Monad m where
    (>>=) :: thing a -> (a -> thing b) -> thing b

-}

instance Functor Result where
    fmap = gmap

instance Applicative Result where

instance Monad Result where
    (>>=) = pat





pat :: Result a -> (a -> Result b) -> Result b
pat r fv =
  case r of
    Error msg -> Error msg
    Value v   -> fv v

eval :: Exp -> Result Int
eval (Num n) =
    Value n

eval (Add e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    Value (v1 + v2)

eval (Div e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    if v2 == 0
      then throw ("oh no! DBZ thanks to " ++ show e2)
      else Value (v1 `div` v2)

{-
    (>>=) e1 (\x1 ->
        (>>=) e2 (\x2 ->
            (>>=) e3 (\x3 ->
                STUFF
            )
        )
    )

    do x1 <- e1
       x2 <- e2
       x3 <- e3
       STUFF

    do
        x1 <- e1
        x2 <- e2
        x3 <- e3
        STUFF


-}






throw :: String -> Result a
throw msg = Error msg

evalWithCatch :: Exp -> Int
evalWithCatch e =
    eval e
    `catch`
        (\_ -> -1)

catch :: Result Int -> (String -> Int) -> Int
catch res handler =
    case res of
        Value n -> n
        Error msg -> handler msg

-- eval :: Exp -> Int
-- eval e = case e of
--             Num n     -> n
--             Add e1 e2 -> eval e1 +     eval e2
--             Div e1 e2 -> eval e1 `div` eval e2
