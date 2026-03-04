#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 9B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 3, day: 5),
)

#quiz(name: "Recursion over Tree 1")[

  Fill in the implementation of `showTree`

  ```haskell
  -- >>> showTree (Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf))
  -- (Node "2" (Node "1" Leaf Leaf) (Node "3" Leaf Leaf))

  showTree :: Tree Int -> Tree String

  showTree Leaf         = _____________________________________________

  showTree (Node v l r) = _____________________________________________
  ```

]

#quiz(name: "Recursion over Tree 2")[

  Fill in the implementation of `showTree`

  ```haskell
  -- >>> sqrTree (Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf))
  -- (Node 4 (Node 1 Leaf Leaf) (Node 9 Leaf Leaf))

  sqrTree :: Tree Int -> Tree Int

  sqrTree Leaf         = _____________________________________________

  sqrTree (Node v l r) = _____________________________________________
  ```
]

#quiz(name: "Refactor into mapTree")[

  Let's refactor recurision into `mapTree` --  what is it's *type*?


  ```haskell
  mapTree :: ______________________________________________

  showTree t = mapTree (\n -> show n) t
  sqrTree  t = mapTree (\n -> n ^ 2)  t
  ```

]

#quiz(name: "A Typeclass for Mappable")[

  Common pattern about the `List` and `Tree` datatypes

  ```haskell
  mapList :: (a -> b) -> List a -> List b    -- List
  mapTree :: (a -> b) -> Tree a -> Tree b    -- Tree
  ```

  Lets refactor into a *typeclass*; what should the *generic type* of `gmap` be?

  ```haskell
  class Mappable t where
    gmap ::  _____________________________________________
  ```
]

#quiz(name: "Mappable for Result")[
  Here is a definition of a `Result a` datatype

  ```haskell
  data Result a = Error String | Value a
  ```

  Fill in the implementation of `Mappable Result`

  ```haskell
  instance Mappable Result where
    gmap f (Error msg) = _____________________________________________
    gmap f (Value val) = _____________________________________________
  ```
]

#quiz(name: "bind")[
  What is the type of `bind` defined below?

  ```haskell
  bind :: _____________________________________________
  bind (Error msg) k = Error msg
  bind (Value val) k = k val
  ```
]

#quiz(name: "Eval with bind")[

  ```haskell
  eval :: Expr -> Result Int

  eval (Number n)   = _________________________________________

  eval (Plus e1 e2) = _________________________________________
  p
                      _________________________________________

                      _________________________________________

  eval (Div  e1 e2) = _________________________________________

                      _________________________________________

                      _________________________________________
  ```
]


#quiz(name: "Your turn!")[

  What is something you found confusing in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
