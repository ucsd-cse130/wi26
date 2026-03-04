#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 8B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 2, day: 26),
)


#quiz(name: "Regular Expressions")[
  Which of the following strings are matched by `[a-z A-Z] [a-z A-Z 0-9]*`?

  1. (empty string)
  2. `5`
  3. `x5`
  4. `x`
  5. `c` and `d`
]

#quiz(name: "Lexing")[
  What is the result of `parseTokens "92zoo"` (positions omitted for readability)?

  1. Lexical error
  2. `[ID "92zoo"]`
  3. `[NUM "92"]`
  4. `[NUM "92", ID "zoo"]`

]

#quiz(name: "Parsing")[
  What is the value of the root `Aexpr` node when parsing `1 + 2 + 3`
  using the grammar below?

  ```haskell
  Aexpr : TNUM                    { AConst $1    }
        | ID                      { AVar   $1    }
        | '(' Aexpr ')'           { $2           }
        | Aexpr '*' Aexpr         { AMul   $1 $3 }
        | Aexpr '+' Aexpr         { APlus  $1 $3 }
        | Aexpr '-' Aexpr         { AMinus $1 $3 }
  ```

  1. Cannot be parsed as `Aexpr`
  2. `6`
  3. `APlus (APlus (AConst 1) (AConst 2)) (AConst 3)`
  4. `APlus (AConst 1) (APlus (AConst 2) (AConst 3))`
]

#quiz(name: "Evaluation")[
  Suppose we used the *same grammar as above*; what would be
  the result of evaluating the following

  ```haskell
  ghci> evalString [] "1 + 3 + 6"
  10

  ghci> evalString [("x", 100), ("y", 20)] "x - y"

  ______________________________________

  λ> evalString [] "2 * 5 + 5"

  ______________________________________

  λ> evalString [] "2 - 1 - 1"

  ______________________________________
  ```
]

#quiz(name: "Your turn!")[
  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
