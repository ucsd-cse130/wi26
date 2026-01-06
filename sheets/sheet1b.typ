#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 1B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 1, day: 8),
  // Here you can customize the layout of the page, the header, the widgets.
  // Look at the parameters of the `assignment` function.
)

#quiz(name: "Free vs. Bound")[
  Which variables *occur free* in the expression `(x (\y -> z))`?

  1. `x`, `y`
  2. `y`, `z`
  3. `x`, `z`
  4. `x`, `y`, `z`
  5. none
]

#quiz(name: "β-step")[
  What does the following $lambda$-term step to?

  ```haskell
  ((\x -> (\y -> y)) apple)   =b>   ???
  ```

  1. `apple`
  2. `\y -> apple`
  3. `\x -> apple`
  4. `\y -> y`
  5. `\x -> y`
]

#quiz(name: "β-step")[
  What does the following $lambda$-term step to?

  ```haskell
  (\x -> (((y x) y) x)) apple   =b>   ???
  ```

  1. `(((apple apple) apple) apple)`
  2. `(((y apple) y) apple)`
  3. `(((y y) y) y)`
  4. `apple`
]

#quiz(name: "β-step")[
  What does the following $lambda$-term step to?

  ```haskell
  ((\x -> (x (\x -> x))) apple)   =b>   ???
  ```

  1. `(apple (\x -> x))`
  2. `(apple (\apple -> apple))`
  3. `(apple (\x -> apple))`
  4. `apple`
  5. `(\x -> x)`
]

// #pagebreak()

#quiz(name: "Backwards Step")[

  What is a $lambda$-term `FILL_THIS_IN` such that


  ```haskell
  let FILL_THIS_IN = ____________________________________________`

  FILL_THIS_IN apple
  =b>   banana
  ```
]

#quiz(name: "Normal Forms")[

  Which of the following term are *not* in _normal form_ ?

  1. `x`
  2. `(x y)`
  3. `((\x -> x) y)`
  4. `(x (\y -> y))`
  5. C and D

]

#quiz(name: "Take Three")[

  Fill in the definitions of `FIRST`, `SECOND` and `THIRD`
  such that you get the following behavior in `elsa`

  ```haskell
  let FIRST  = fill_this_in
  let SECOND = fill_this_in
  let THIRD  = fill_this_in

  eval ex1 :
    FIRST apple banana orange
    =*> apple

  eval ex2 :
    SECOND apple banana orange
    =*> banana

  eval ex3 :
    THIRD apple banana orange
    =*> orange
  ```

]

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
