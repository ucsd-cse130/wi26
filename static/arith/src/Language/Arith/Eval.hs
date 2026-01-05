{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module Language.Arith.Eval
  (
  -- * Run a file, string or expr
    evalFile
  , evalString
  , evalExpr

  -- * Convert string to AST
  , parse
  -- * Convert string to Tokens
  , tokens
  )
  where

import Control.Exception (catch)
import Language.Arith.Types
import Language.Arith.Lexer ( Token )
import Language.Arith.Parser

--------------------------------------------------------------------------------
evalFile :: FilePath -> IO ()
--------------------------------------------------------------------------------
evalFile f = runFile f `catch` exitError

runFile :: FilePath -> IO ()
runFile f = do
  str  <- readFile f
  let n = evalString [] str
  putStrLn ("Result = " ++ show n)

exitError :: Error -> IO ()
exitError (Error msg) = putStrLn ("Error: " ++ msg)


-- >>> parseTokens "90027zig 007"
-- Right [NUM (AlexPn 0 1 1) 90027,ID (AlexPn 5 1 6) "zig",NUM (AlexPn 9 1 10) 7]



-- >>> parseTokens "10 + 20 - z00"
-- Right [NUM (AlexPn 0 1 1) 10,PLUS (AlexPn 3 1 4),NUM (AlexPn 5 1 6) 20,MINUS (AlexPn 8 1 9),ID (AlexPn 10 1 11) "z00"]

-- >>> parse "10 - 2 - 2"
-- >>> evalString [] "10 - 2 - 2"
-- AMinus (AMinus (AConst 10) (AConst 2)) (AConst 2)
-- 6

-- >>> evalString [] "2 * 5 + 5"
-- 15


-- [  NUM (AlexPn 0 1 1) 10,
--    PLUS (AlexPn 3 1 4),
--    NUM (AlexPn 5 1 6) 20,
--    MINUS (AlexPn 8 1 9),
--    ID (AlexPn 10 1 11) "z"
-- ]



-- ==> [Num 10, Plus, Num 20, Minus, Id "z"]

-- >>> evalString [("z", 100)] "10 + 20 - z"
-- -70






-- >>> parseAexpr "(2)+9"

-- >>> evalString [] "10 * 2 + 1"


-- >>> parseAexpr "(1 + (2 + (3 + (4 + 5)))))"

-- >>> parseAexpr "+ + + "


-- >>> parseTokens "20000z987"

-- >>> parseTokens "+"

-- >>> parseTokens "z"

-- >>> parseAexpr "(x + y + 100)/2000"

--------------------------------------------------------------------------------
evalString :: Env -> String -> Value
--------------------------------------------------------------------------------
evalString env s = evalExpr env (parseAexpr s)

--------------------------------------------------------------------------------
evalExpr :: Env -> Aexpr -> Value
--------------------------------------------------------------------------------
evalExpr = eval

--------------------------------------------------------------------------------
-- | `parse s` returns the Expr representation of the String s
--
-- >>> parse "123"
-- AConst 123
--
-- >>> parse "foo"
-- AVar "foo"
--
-- >>> parse "x + y"
-- APlus (AVar "x") (AVar "y")
--
-- >>> parse "10 - 2 - 2"
-- AMinus (AConst 10) (AMinus (AConst 2) (AConst 2))
--
-- >>> parse "2 + 10 * 3"
-- APlus (AConst 2) (AMul (AConst 10) (AConst 3))

--------------------------------------------------------------------------------
parse :: String -> Aexpr
--------------------------------------------------------------------------------
parse = parseAexpr

--------------------------------------------------------------------------------
tokens :: String -> Either String [Token]
--------------------------------------------------------------------------------
tokens = parseTokens
