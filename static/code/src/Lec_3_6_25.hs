{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module Lec_3_6_25  where


-- >>> 2 + 4
-- 6

-- >>> 2.32 + 4.98
-- 7.300000000000001

-- >>> (["dog"], ("cat", 10)) < (["dog"], ("cat", 20))
-- True

-- >>> True + False
-- No instance for (Num Bool) arising from a use of `+'
-- In the expression: True + False
-- In an equation for `it_afai': it_afai = True + False




-- >>> :info (+)
-- type Num :: * -> Constraint
-- class Num a where
--   (+) :: a -> a -> a
--   ...
--   	-- Defined in ‘GHC.Num’
-- infixl 6 +

foo :: Num a => a -> a -> a
foo x y = x + y

data WeekDay = Mon | Tue | Wed | Thu | Fri
    deriving (Eq, Ord, Show, Read)

-- instance Show WeekDay where
--   show Mon = "Mon"
--   show Tue = "Tue"
--   show _   = "???"

-- instance Eq WeekDay where
--     (==) :: WeekDay -> WeekDay -> Bool
--     (==) Mon Mon = True
--     (==) Tue Tue = True
--     (==) Wed Wed = True
--     (==) Thu Thu = True
--     (==) Fri Fri = True
--     (==) _   _   = False

-- instance Ord WeekDay where
--   (<=) :: WeekDay -> WeekDay -> Bool
--   (<=) d1 d2 = weekDayInt d1 <= weekDayInt d2

weekDayInt :: WeekDay -> Int
weekDayInt Mon = 0
weekDayInt Tue = 1
weekDayInt Wed = 2
weekDayInt Thu = 3
weekDayInt Fri = 4

-- >>> Mon < Tue


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
-- instance Eq Integer -- Defined in ‘GHC.Num.Integer’


bar :: Eq a => a -> a -> Bool
bar x y = x == y


data Env k v = MkEnv v [(k, v)]
  deriving (Read, Show)

get :: (Ord k) => k -> Env k v -> v
get _ (MkEnv v []) = v
get key (MkEnv v ((k, val):rest))
  | key == k  = val
  | key <  k  = v
  | otherwise = get key (MkEnv v rest)

-- EXERCISE: fix `set` so that `get "cat" env0` returns `10`
set :: k -> v -> Env k v -> Env k v
set key val (MkEnv v vals) = MkEnv v ((key, val):vals)

empty :: v -> Env k v
empty v = MkEnv v []


-- >>> get "cat" env0

env0 =
  let e0 = empty 100
      e1 = set "cat" 10 e0
      e2 = set "dog" 20 e1
  in
      e2

-- env1 = Bind Mon "monday" (Bind Tue "tuesday" (Def "???"))


data JVal
  = JStr  String
  | JNum  Double
  | JBool Bool
  | JObj  [(String, JVal)]
  | JArr  [JVal]
  deriving (Eq, Ord, Show)

js1 :: JVal
js1 =
  JObj [("name", JStr "Ranjit")
       ,("age",  JNum 47.0)
       ,("likes",   JArr [ JStr "guacamole", JStr "coffee", JStr "bacon"])
       ,("hates",   JArr [ JStr "waiting"  , JStr "grapefruit"])
       ,("lunches", JArr [ JObj [("day",  JStr "monday")
                                ,("loc",  JStr "zanzibar")]
                         , JObj [("day",  JStr "tuesday")
                                ,("loc",  JStr "farmers market")]
                         , JObj [("day",  JStr "wednesday")
                                ,("loc",  JStr "hare krishna")]
                         , JObj [("day",  JStr "thursday")
                                ,("loc",  JStr "faculty club")]
                         , JObj [("day",  JStr "friday")
                                ,("loc",  JStr "coffee cart")]
                         ])
       ]

class ToJVal a where
  mkJVal :: a -> JVal

instance ToJVal Double where
  mkJVal d = JNum d

instance ToJVal Integer where
  mkJVal d = JNum (fromIntegral d)

-- instance ToJVal String where
--   mkJVal s = JStr s

instance ToJVal Bool where
  mkJVal b = JBool b

instance ToJVal a => ToJVal [a] where
  mkJVal xs = JArr (map mkJVal xs)

instance ToJVal v => ToJVal (Env String v) where
  mkJVal (MkEnv def keyvals) = JObj (("default", mkJVal def) : rest)
    where
       rest = map (\(k, v) -> (k, mkJVal v)) keyvals

listD :: [Double]
listD = [2.2, 3.3, 4.4]

-- listS :: [String]
-- listS = ["beans", "cheese", "salsa"]

jv1 = mkJVal listD
-- jv2 = mkJVal listS