#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 10A",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 3, day: 10),
)


#quiz(name: "Eval returning a Result")[
  Here is a definition of a `Result a` datatype

  ```haskell
  data Result a = Error String | Value a
  ```

  Modify `eval` so it returns a `Result Int`. 

  ```haskell
  eval :: Expr -> Result Int

  eval (Number n)   = _________________________________________

  eval (Plus e1 e2) = _________________________________________
  
                      _________________________________________

                      _________________________________________

                      _________________________________________
                      
                      _________________________________________

  eval (Div  e1 e2) = _________________________________________

                      _________________________________________

                      _________________________________________
                      
                      _________________________________________
                      
                      _________________________________________


  ```

  When you are done, we should get the following behavior

  ```
  >>> eval (Plus (Number 2) (Number 5))
  Value 7
  >>> eval (Div (Plus (Number 2) (Number 5)) (Plus (Number 2)  (Number (-2))))
  Err "DBZ: Plus (Number 2) (Number (-2))" 
  ```
]


#quiz(name: "A Typeclass for Mappable")[

  Recall the `map` pattern for the `List` and `Tree` datatypes

  ```haskell
  mapList :: (a -> b) -> List a -> List b    -- List
  mapTree :: (a -> b) -> Tree a -> Tree b    -- Tree
  ```

  We factored those into a *typeclass* `Mappable`

  ```haskell
  class Mappable t where
    gmap ::  (a -> b) -> t a -> t b
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
