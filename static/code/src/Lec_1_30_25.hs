{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
{-# HLINT ignore "Use list literal" #-}
{-# HLINT ignore "Use foldr" #-}
module Lec_1_30_25 where




ex0 :: Integer
ex0 = 12 + 3

ex1 :: Double
ex1 = 12.3 + 3.15

ex3 :: Char
ex3 = 'c'

ex4 :: Bool
ex4 = True

ex5 :: Integer -> Integer
ex5 n = n + 1

-- >>> ex5 10
-- 11

ex6 :: (Integer, Bool, Integer -> Integer)
ex6 = (6, True, ex5)

ex7 :: ((Integer, Bool, Integer -> Integer), (Integer, Bool, Integer -> Integer))
ex7 = (ex6, ex6)

ex8 :: ()
ex8 = ()


list0 :: [Integer]
list0 = [1,2,3,4,5,6,7,8]

list1 :: [Char]
list1 = ['a', 'b', 'c']
list1' =  'a' : ('b' : ('c' : []))

list2 :: [(Integer, Integer)]
list2 = [(1,2), (3,3), (4,5)]

list2' :: [(Integer, Integer)]
list2' = (1, 2) : (3, 3) : (4, 5) : []

-- >>> "this is a string"
-- "this is a string"

-- >>> mytake 0 [0,1,2,3,4,5]
-- []

-- >>> mytake 3 [0,1,2,3,4,5]
-- [0,1,2]

-- >>> mytake 30 [0,1,2,3,4,5]
-- [0,1,2,3,4,5]

-- >>> mytake 3 "this is a string"
-- "thi"



-- >>> copy3 "cat"
-- ["cat","cat","cat"]

-- >>> copy3 49
-- [49,49,49]

copy3 :: t -> [t]
copy3 x = [x,x,x]

-- >>> clone 4 [4,9]
-- [[4,9],[4,9],[4,9],[4,9]]

bob :: [Double]
bob = []

clone :: Int -> t -> [t]

-- clone 0 x = []
-- clone n x = x : clone (n-1) x

clone n x = case n of
                0 -> []
                _ -> x : clone (n-1) x

-- >>> range 5 12
-- [5,6,7,8,9,10,11,12]


range :: Int -> Int -> [Int]
-- range lo hi = if lo > hi then [] else lo : range (lo+1) hi
-- range lo hi
--   | lo > hi   = []
--   | otherwise = lo : range (lo+1) hi
range lo hi = case lo > hi of
                True -> []
                False -> lo : range (lo+1) hi


{-

| cond1 = e1
| cond2 = e2
| cond3 = e3
| otherwise = e4

if cond1
    then e1
    else if cond2
         then e2
         else if cond3
              then e3
              else e_default
-}

-- range lo hi  ===> [lo, lo+1, lo+2,...hi  ]
-- >>> firstElem ["cat", "dog", "horse"]
-- "cat"

-- >>> firstElem [10,20]
-- >>> firstElem []
-- 10
-- Oh no! there's no elemes in the freeaking list

firstElem :: [t] -> t
firstElem (cat: _) = cat
firstElem []       = error "Oh no! there's no elemes in the freeaking list"

firstElem' :: [t] -> t
firstElem' xs = case xs of
                  (cat: _) -> cat
                  []       -> error "Oh no! there's no elemes in the freeaking list"

mystery :: [t] -> Int
mystery []     = 0
mystery (x:xs) = 1 + mystery xs

{-

mystery (10:(20:(30:[])))
==>
1 + mystery (20:(30:[]))
==>
1 + (1 + (mystery (30:[])))
==>
1 + (1 + (1 + mystery []))
==>
1 + (1 + (1 + 0))
==>
3


-}
-- mystery l = case l of
--                 [] -> 0
--                 x:xs -> 1 + mystery xs


-- sumList [x1,x2,x3,..xn] = x1 + x2 + x3 + ... + xn

-- >>> sumList [10, 20, 30]

sumList :: [Int] -> Int
-- sumList []     = 0
-- sumList (x:xs) = x + sumList xs
sumList l = case l of
              []   -> 0
              x:xs -> x + sumList xs


mytake :: Int -> [t] -> [t]

-- mytake 0 _       = []
-- mytake _ []      = []
-- mytake n (x1:xs) = x1: mytake (n-1) xs

mytake n l = case (n, l) of
               (0, _) -> []
               (_, []) -> []
               (_, x:xs) -> x : mytake (n-1) xs

-- if cond then e1 else e2

-- case cond of
--   True -> e1
--   False -> e2

-- >>> [] : []
-- [[]]

-- What is [] : [] ???

-- h : t      first elem is `h`, rest is `t`
