{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}

module Lec_2_10_2026 where

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

insertLeft :: Int -> List t -> List t
insertLeft n l = ICons n l

-- >>> insertRight 0 (ICons 24 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (ICons 0 IEmp)))

-- insertRight 0 (ICons 24 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (insertRight 0 (ICons 56 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (insertRight 0 (ICons 99 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (insertRight 0 IEmp)))
-- ICons 24 (ICons 56 (ICons 99 (ICons 0 IEmp)))




insertRight :: Int -> List -> List
insertRight n IEmp        = ICons n IEmp
insertRight n (ICons h t) = ICons h (insertRight n t)
