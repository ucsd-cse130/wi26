#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 5A",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 2, day: 3),
)


#quiz(name: "Sum Types")[

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

#quiz(name: "Tail Recursion")[

  Is this function tail recursive? *Yes* or *No* (circle one)

  ```haskell
  fac :: Int -> Int
  fac n
    | n <= 1    = 1
    | otherwise = n * fac (n - 1)
  ```

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

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
