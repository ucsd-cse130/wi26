#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 8A",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 2, day: 24),
)

#quiz(name: "Lambdas with Free Variables")[
  What should the following expression evaluate to?

  ```haskell
  let c = 1
  in
     let inc = \x -> x + c
     in
        let c = 100
        in
          inc 10

  -- >>> quiz

  ______________________________________
  ```
]

#quiz(name: "Creating Lambdas")[

  What should the following evaluate to?

  ```haskell
  quiz =
    let add = \x -> (\y -> x + y)
    in
      let add10 = add 10
      in
        let add20 = add 20
        in
          -- (q2)
          (add10 100) + (add20 1000)

  -- >>> eval [] quiz

  ______________________________________
  ```
]

#quiz(name: "Environment")[
  In the example above, what does the environment look like at `q2`?

  #table(
    columns: 2,
    [*variable*], [*value*],
    [`________`], [`________________________________________`],
    [`________`], [`________________________________________`],
    [`________`], [`________________________________________`],
  )
]


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


#quiz(name: "Your turn!")[
  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
