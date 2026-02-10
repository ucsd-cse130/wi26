#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 5B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 2, day: 5),
)



#quiz(name: "Binary Trees I")[

  #grid(
    columns: (1fr, 1.5fr),
    gutter: 1em,
    [
      #figure(
        image("../static/img/tree-data-node.png", width: 60%),
        caption: "A binary tree with data at node",
      )
    ],
    [
      Fill in a haskell representation of the tree on the left.

      ```haskell
        data Tree a = ______________ | _______________

        tree0 :: Tree Int

        tree0 = ______________________________________

                ______________________________________
      ```
    ],
  )

]


#quiz(name: "Binary Trees II")[

  #grid(
    columns: (1.5fr, 1fr),
    gutter: 1em,
    [
      Fill in a haskell representation of the tree on the right.

      ```haskell
        data Tree a = ______________ | _______________

        tree1 :: Tree Int

        tree1 = ______________________________________

                ______________________________________
      ```
    ],
    [
      #figure(
        image("../static/img/tree-data-leaf.png", width: 60%),
        caption: "A binary tree with data at node",
      )

    ],
  )

]

#quiz(name: "Accumulation")[

  Can you write a tail-recursive `factorial`?

  ```haskell
  facTR :: Int -> Int
  facTR n = __________________________________________

      ________________________________________________

      ________________________________________________

      ________________________________________________

      ________________________________________________
  ```
]

#quiz(name: "Filter")[

  What is the type of `filter`?

  ```haskell
  filter :: ________________________________________________

  -- >>> evens [1,2,3,4]
  -- [2,4]
  evens :: [Int] -> [Int]
  evens xs = filter isEven xs
    where
      isEven :: Int -> Bool
      isEven x  =  x `mod` 2 == 0

  -- >>> fourChars ["i","must","do","work"]
  -- ["must","work"]
  fourChars :: [String] -> [String]
  fourChars xs = filter isFour xs
    where
      isFour :: String -> Bool
      isFour x  =  length x == 4
  ```
]

#quiz(name: "Map")[
  What is the type of `map`?

  ```haskell
  map :: ________________________________________________
  map f []     = []
  map f (x:xs) = f x : map f xs
  ```
]


#quiz(name: "Fold Right")[

  What does `quiz` evaluate to?

  ```haskell
  foldr f b []     = b
  foldr f b (x:xs) = f x (foldr f b xs)

  quiz = foldr (\x v -> x : v) [] [1,2,3]

  -- >>> quiz
  ________________________________________________
  ```
]


#quiz(name: "Fold Left")[

  What does `quiz` evaluate to?

  ```haskell
  foldl f b xs          = helper b xs
    where
      helper acc []     = acc
      helper acc (x:xs) = helper (f acc x) xs

  quiz = foldl (\xs x -> x : xs) [] [1,2,3]

  -- >>> quiz
  -- ________________________________________________
  ```
]

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
