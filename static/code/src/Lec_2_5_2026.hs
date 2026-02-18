{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}

module Lec_2_5_2026 where

import Text.Printf (printf)

data Silly
    = Goose            -- :: Silly
    | Honk Silly       -- :: Silly -> Silly
    deriving (Show)



mmm :: Silly -> Silly -> Silly
mmm Goose    m = m
mmm (Honk s) m = mmm s (Honk m)


-- mmm (Honk (Honk Goose)) (Honk n)
-- ==> mmm (Honk Goose) (Honk (Honk n))
-- ==> mmm (Goose) (Honk (Honk (Honk n)))
-- ==> (Honk (Honk (Honk n)))



-- mmm ((Honk Goose)) (Honk n)
-- mmm Goose (Honk n) = Honk (Honk (Honk (Honk (Honk n))))


-- mmm (Honk n) (Honk (Honk Goose)) = Honk (Honk (Honk n))

-- mmm (Honk n) m = Honk (mmm n m)

-- mmm (Honk n)



-- mmm (Honk (Honk (Honk Goose))) m
-- ==>
-- mmm ((Honk (Honk Goose))) (Honk m)

-- ==>
-- mmm (((Honk Goose))) (Honk (Honk (Honk (Honk Goose))))
-- ==>
-- mmm Goose (Honk (Honk (Honk (Honk (Honk Goose)))))
-- ==>
--  (Honk (Honk (Honk (Honk (Honk Goose)))))




-- (Honk (Honk (Honk (Honk (Honk Goose)))))


-- >>> :t (Honk Honk)
-- Couldn't match expected type `Silly'
--             with actual type `Silly -> Silly'
-- Probable cause: `Honk' is applied to too few arguments
-- In the first argument of `Honk', namely `Honk'
-- In the expression: Honk Honk


data List t
    = IEmp
    | ICons t (List t)
    deriving (Show)

list0 :: List Int
list0 = ICons 24 (ICons 56 (ICons 99 IEmp))

-- >>> insertLeft 0 list0
-- ICons 0 (ICons 24 (ICons 56 (ICons 99 IEmp)))

insertLeft :: t -> List t -> List t
insertLeft n l = ICons n l

-- >>> insertRight 0 (ICons 24 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (ICons 0 IEmp)))

-- insertRight 0 (ICons 24 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (insertRight 0 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (insertRight 0 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (insertRight 0 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (ICons 0 IEmp)))




insertRight :: t -> List t -> List t
insertRight n IEmp        = ICons n IEmp
insertRight n (ICons h t) = ICons h (insertRight n t)



data Tree t
  = Leaf
  | Node t (Tree t) (Tree t)
  deriving (Show)

tree0 :: Tree Int
tree0 =
  Node 1
    (Node 2
        (Node 3 Leaf Leaf)
        Leaf
    )
    (Node 4 Leaf Leaf)

-- >>> sumTree tree0
-- 10

sumTree :: Tree Int -> Int
sumTree t = case t of
                Leaf -> 0
                Node val l r -> val + sumTree l + sumTree r

-- >>> height tree0
-- 3

height :: Tree t -> Int
height t = case t of
                Leaf -> 0
                Node _ l r -> 1 + max (height l) (height r)



---
{-
def fac(n):
  res = 1
  i = 1

  while i <= n:
    res = res * i
    i   = i + 1

  return res


def fac(n):
  res = 1
  i = n

  while 1 <= i:
    res = res * i
    i   = i - 1

  return res


-}

fac :: Int -> Int
fac n = if n <= 1 then 1 else n * fac(n-1)


-- < fac 5 >
-- < 5 * < fac 4 > >
-- < 5 * < 4 * <fac 3> > >
-- < 5 * < 4 * < 3 * <fac 2> > > >
-- < 5 * < 4 * < 3 * <2 * < fac 1> > > > >
-- < 5 * < 4 * < 3 * <2 * 1  > > > >
-- < 5 * < 4 * < 3 * 2 > > >
-- < 5 * < 4 * 6 > >
-- < 5 * 24 >
-- 120