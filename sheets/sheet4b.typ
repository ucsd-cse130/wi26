#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 4B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 1, day: 29),
)


#quiz(name: "First Element")[
  Write a function `firstElem` that returns the first element of a list or `0` if the list is empty

  ```haskell
  firstElem ::  ___________________________________________

  firstElem l = ___________________________________________

                ___________________________________________

                ___________________________________________
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


#quiz(name: "Take: Specification")[

  Fill in the implementation of a function `take` that returns the first `n` elements of a list.

  ```haskell
  -- >>> take 0 [10, 20, 30]
  -- ___________________________________________

  -- >>> take 1 [10, 20, 30]
  -- ___________________________________________

  -- >>> take 2 [10, 20, 30]
  -- ___________________________________________

  -- >>> take 4 [10, 20, 30]
  -- ___________________________________________
  ```
]

#quiz(name: "Take: Implementation")[

  Fill in the implementation of a function `take` that returns the first `n` elements of a list.

  ```haskell
  take      :: _____________________________________

  take n []     = __________________________________

  take n (x:xs) = __________________________________
  ```
]


#quiz(name: "Sum-Types")[

  Suppose we define a datatype

  ```haskell
  data Paragraph
    = PText String
    | PHeading Int String
    | PList Bool [String]
  ```

  What is the type of

  ```haskell
  quiz :: _______________________________________________

  quiz =  [PHeading 1 "Introduction", PText "Hey there!"]
  ```
]


#quiz(name: "Pattern Matching")[

  What is the *type of*

  ```haskell
    quiz1 :: ___________________________________________
    quiz1 = case (PText "Hey there!") of
              PText    str   -> str
              PHeading lvl _ -> lvl
              PList    ord _ -> ord

    quiz2 :: ___________________________________________
    quiz2 = case PText "Hey there!" of
              Text _      -> 5
              Heading l _ -> l
              List _ _    -> 6
  ```
]

#quiz(name: "Funny Numbers")[

  ```haskell
  data Nat = Zero     -- base constructor
           | Succ Nat -- inductive constructor
  ```

  What is the _type_ of `foo` ?

  ```haskell
  foo :: ___________________________________________
  foo i = if i <= 0 then Zero else Succ (foo (i - 1))
  ```

  What does `foo 2` evaluate to?

  ```haskell
  -- >>> foo 2
  -- >>> ________________________________________________
  ```
]

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
