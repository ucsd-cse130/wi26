{- HLINT ignore "Use unless" -}

import Text.Printf (printf)
import System.Environment
import System.IO

-- >>> headAny [1,2,3]
-- "cat"

headInt :: [Int] -> Int
headInt (n:_) = n

headAny :: [a] -> a
headAny (n:_) = n

type Recipe a = IO a

main :: IO ()
main = do
  cow <- readFile "cow.txt"
  msg <- getInput
  cowSays cow msg

cowSays :: String -> String -> IO ()
cowSays cow msg = do
  let out = blurb (msgLines lineSize msg)
  putStrLn (out ++ cow)

getInput :: IO String
getInput = do
  args <- getArgs
  case args of
    [] -> hGetContents stdin
    _  -> return (unwords args)

---------------------------------------------------------


lineSize :: Int
lineSize = 40

blurb :: [String] -> String
blurb lines = unlines
  $  hdr
  :  [ printf "< %s >" (pad l) | l <- lines ]
  ++ [ hdr ]
  where
    pad l = l ++ replicate (n - length l) ' '
    n     = min lineSize (maximum (map length lines))
    hdr   = " " ++ replicate (n + 2) '-' ++ " "

msgLines :: Int -> String -> [String]
msgLines n str = go [] (words str)
  where
    go acc []  = reverse acc
    go acc ws  = let (l, rest) = splitAtSize n ws
                 in go (unwords l: acc) rest

splitAtSize :: Int -> [String] -> ([String], [String])
splitAtSize n words  = go n [] words
  where
    go k acc (w:ws)
      | length w < k = go (k - length w - 1) (w:acc) ws
      | otherwise    = (reverse acc, w:ws)
    go k acc []      = (reverse acc, [])


-- main :: Recipe ()
-- main = undefined -- helper 0

-- helper :: Int -> Recipe ()
-- helper counter = do
--     putStrLn (printf "[%d] Yo, what's your name?????" counter)
--     name <- getLine
--     if name == "QUIT"
--       then putStrLn "Oh well, so long, etc etc."
--       else do putStrLn ("Hello, " ++ name)
--               helper (counter + 1)


-- {-

-- do _ <- e1
--    x <- e2
--    _ <- e3
--    STUFF


-- do x1 <- e1
--    x2 <- e2
--    x3 <- e3
--    REST

-- e1 >>= \x1 ->
--     e2 >>= \x2 ->
--         e3 >>= \x3 ->
--             REST


-- do
--     name <- getLine
--     putStrLn ("Hello, World! " ++ name)
--     main
-- -----------------
-- do
--     name <- getLine
--     _ <- putStrLn ("Hello, World! " ++ name)
--     main
-- -----------------

-- getLine >>= \name ->
--     do _ <- putStrLn ("Hello, World! " ++ name)
--        main
-- -----------------
-- getLine >>= \name ->
--     putStrLn ("Hello, World! " ++ name) >>= \_ ->
--        main
-- -}


-- {-

--     e1 >>= \x -> e2

--     do x <- e1
--        e2
-- -}

-- {-
--     main =
--         combine
--             (print "hello")
--             (print "world")

--     combine :: Recipe a -> Recipe b -> Recipe b


--   let name = input ()
--     in
--         print ("hello, " ++ name)

-- -}
