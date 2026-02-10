#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 3A",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 1, day: 20),
)


#quiz(name: "If-Then-Else Expressions")[

  What is the *type* and *value* of `quiz1` and `quiz2`?

  ```haskell
  ex6 :: Int
  ex6 = 4 + 5

  ex7 :: Int
  ex7 = 4 * 5

  ex8 :: Bool
  ex8 = 5 > 4

  quiz1 :: ___________________________________________________
  quiz1 = if ex8 then ex6 else ex7

  -- >>> quiz1
  -- ___________________________________________________

  quiz2 :: ___________________________________________________
  quiz2 = if ex8 then ex6 else "ex7"

  -- >>> quiz1
  -- ___________________________________________________
  ```
]

#quiz(name: "Tuples")[

  What is the *type* of `tup3`?

  ```haskell
  tup3 :: ______________________________________________
  tup3 = ((7, 5.2), True)
  ```
]

#quiz(name: "case-of")[
  What is the value of `quiz` defined as

  ```haskell
  tup2 :: (Char, Double, Int)
  tup2 = ('a', 5.2, 7)

  snd3 :: (t1, t2, t3) -> t2
  snd3 t = case t of
             (x1, x2, x3) -> x2

  quiz = snd3 tup2

  -- >>> quiz
  -- ___________________________________________________
  ```
]

#quiz(name: "Lists")[

  What is the type of `things` defined as

  ```haskell
  things :: _____________________________________________
  things = [ [1], [2, 3], [4, 5, 6] ]
  ```
]

#quiz(name: "Mystery")[


  Suppose we have the following `mystery` function

  ```haskell
  mystery :: [a] -> Int
  mystery l = case l of
                []     -> 0
                (x:xs) -> 1 + mystery xs
  ```

  What does the following evaluate to?

  ```haskell
    -- >>> mystery [10, 20, 30]
    -- ___________________________________________________
  ```
]

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
