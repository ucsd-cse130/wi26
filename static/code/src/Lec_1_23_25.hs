{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
module Lec_1_23_25 where

{-
    def add(x, y):
        return x + y

    add(1,2)
    add(1.1, 2.2)
    add("cat", "dog")


  -}


ex1 :: Double
ex1 = 1 + 2

ex2 :: Double
ex2 = 2.0 + (3.6 * 9.1)

boo :: Bool
boo = True

bob :: Double
bob = if boo then ex1 else ex2


ex3 :: String
ex3 = "cat"
ex4 :: String
ex4 = "dog"

-- >>> ex3 ++ ex4
-- "catdog"

-- >>> isPos 10
-- True

-- >>> isPos (10 - 100)
-- False

{-
    isPos (10 - 100)
    ==>
    isPos (-90)
    ==>
    (-90) > 0
    ==>
    False

-}


isPos :: Int ->  Bool
isPos n = n > 0

-- >>> inc 300
-- 301

inc :: Int -> Int
inc x = x + 1

{-
    10 * (20 + 30)
    12 * (45 + 8)
    19 * (17 + 10)
-}

pat :: Int -> Int -> Int -> Int
-- pat x1 x2 x3 = x1 * (x2 + x3)
-- pat x1 x2 = \x3 -> x1 * (x2 + x3)
-- pat x1 = \x2 -> \x3 -> x1 * (x2 + x3)
-- pat = \x1 -> (\x2 -> (\x3 -> x1 * (x2 + x3)))
-- pat = \x1 x2 x3 -> x1 * (x2 + x3)
pat x1 x2 x3 = x1 * (x2 + x3)

pat_1_2 :: Int -> Int
pat_1_2 = pat 10 20


myMax :: Int -> Int -> Int
myMax x y = if x > y then x else y

sumTo :: Int -> Int
-- sumTo n = if n == 0 then 0 else n + sumTo (n-1)
sumTo 0 = 0
sumTo n = n + sumTo (n-1)



-- >>> pat_1_2 30
-- 500

{-

pat_1_2 30
==>
(pat 10 20) 30
==>...
10 * (20 + 30)
==>
500




pat = \x1 x2 x3 -> x1 * (x2 + x3)



(((pat 1) 2) 3)
==> (((\x2 x3 -> 1 * (x2 + x3)) 2) 3)
==> (((\x3 -> 1 * (2 + x3))) 3)
==> (((1 * (2 + 3))))
==> 1 * (2 + 3)
==> 5

-}

-- >>> pat 1 2 3
-- 5



triple :: (Integer, String, Int -> Bool)
triple = (10,  "20", isPos)

getFst3 :: (t1, t2, t3) -> t1
-- getFst3 t = case t of
--               (x1, _, _) -> x1
getFst3 (x1,_,_) = x1

getSnd3 :: (t1,t2,t3) -> t2
getSnd3 t = case t of
              (_,x2,_) -> x2

-- >>> getSnd3 triple
-- "20"

-- >>> getSnd3 ("cat", "dog", "horse")
-- "dog"
