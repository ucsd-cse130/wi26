#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 2B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 1, day: 15),
)

Recall the definitions from last time

```haskell
let N0  = \f x -> x
let N1  = \f x -> f x
let N2  = \f x -> f (f x)
let N3  = \f x -> f (f (f x)
let N4  = \f x -> f (f (f (f x))
let INC = \n -> (\f x -> f (n f x))
```

#quiz(name: "Addition")[

  Fill in the blank to implement `ADD`

  ```haskell
  let ADD = \n m -> __________________________________________
  ```

  such that

  ```haskell
  ADD N0 N1 =~> N1
  ADD N0 N2 =~> N2
  ADD N1 N1 =~> N2
  ADD N1 N2 =~> N3
  ```
]

#quiz(name: "Multiplication")[

  Fill in the blank to implement `MUL`

  ```haskell
  let MUL = \n m -> __________________________________________
  ```

  such that

  ```haskell
  MUL N0 N1 =~> N0
  MUL N0 N2 =~> N0
  MUL N1 N1 =~> N1
  MUL N1 N2 =~> N2
  MUL N2 N2 =~> N4
  ```
]

#quiz(name: "Lists")[

  How shall we implement

  ```haskell
  let NIL  = ___________________________________________________

  let CONS = ___________________________________________________

  let HEAD = ___________________________________________________

  let TAIL = ___________________________________________________
  ```

  such that

  ```haskell
  eval exHd:
    HEAD (CONS apple (CONS banana (CONS cantaloupe (CONS dragon NIL))))
    =~> apple

  eval exTl
    TAIL (CONS apple (CONS banana (CONS cantaloupe (CONS dragon NIL))))
    =~> CONS banana (CONS cantaloupe (CONS dragon NIL)))
  ```
]

#quiz(name: "Indexing")[

  How shall we implement

  ```haskell
  let GetNth = ___________________________________________________
  ```

  such that we get

  ```haskell
  eval nth1 :
    GetNth N0 (CONS apple (CONS banana (CONS cantaloupe NIL)))
    =~> apple

  eval nth1 :
    GetNth N1 (CONS apple (CONS banana (CONS cantaloupe NIL)))
    =~> banana

  eval nth2 :
    GetNth N2 (CONS apple (CONS banana (CONS cantaloupe NIL)))
    =~> cantaloupe
  ```
]



#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
