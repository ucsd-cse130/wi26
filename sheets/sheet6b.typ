#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 6B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 2, day: 12),
)


#quiz(name: "Type of Fold Right")[
  Fill in the blank with the _type_ of  `foldr`?

  ```haskell
  foldr :: ________________________________________________
  foldr f b []     = b
  foldr f b (x:xs) = f x (foldr f b xs)
  ```
]

#quiz(name: "Tail Recursive Sum")[
  Recall the following function to add up the elements of a list

  ```haskell
  sumList :: [Int] -> Int
  sumList []     = 0
  sumList (x:xs) = x + sumList xs
  ```

  Can you write a *tail-recursive* version of `sumList`?

  ```haskell
  sumListTR xs = helper _______________________________________________
    where
      helper __________________________________________________________

             __________________________________________________________
  ```
]

#quiz(name: "Tail Recursive Concat")[
  Recall the following function to _concatenate_ the strings in a list

  ```haskell
  concat :: [String] -> String
  concat []     = ""
  concat (x:xs) = x ++ concat xs
  ```

  Can you write a *tail-recursive* version of `concat`?

  ```haskell
  concatTR xs = helper _______________________________________________
    where
      helper __________________________________________________________

             __________________________________________________________
  ```
]

#quiz(name: "Typing Fold Left")[

  What is the type of `foldl` defined below?

  ```haskell
  foldl :: ________________________________________________
  foldl f b xs          = helper b xs
    where
      helper acc []     = acc
      helper acc (x:xs) = helper (f acc x) xs

  ```
]

#quiz(name: "Running Fold Left")[

  What does `quiz` evaluate to?

  ```haskell
  quiz = foldl (\xs x -> x : xs) [] [1,2,3]

  -- >>> quiz
  -- ________________________________________________
  ```
]

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
