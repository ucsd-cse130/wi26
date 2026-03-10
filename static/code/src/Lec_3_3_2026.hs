{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}

module Lec_3_3_2026 where

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
