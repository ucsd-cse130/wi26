#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 2A",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 1, day: 13),
)

Recall the definitions from last time

```haskell
let TRUE  = \x1 x2 -> x1
let FALSE = \x1 x2 -> x2
let ITE   = \b x1 x2 -> b x1 x2
```


#quiz(name: "Boolean Operator: Not")[
  How will you implement a `NOT` operator in the $lambda$-calculus, so that
  the following happens

  ```haskell
  let NOT = \b -> _________________________________________________

  eval not_true:
    NOT TRUE  =~>  FALSE

  eval not_false:
    NOT FALSE =~> TRUE
  ```
]

#quiz(name: "Boolean Operator: And")[
  How will you implement a `NOT` operator in the $lambda$-calculus, so that
  the following happens

  ```haskell
  let AND = \b1 b2 -> _________________________________________________

  eval and_tt:
    AND TRUE TRUE  =~>  TRUE
  eval and_tf:
    AND TRUE FALSE =~>  FALSE
  eval and_ft:
    AND FALSE TRUE  =~> FALSE
  eval and_ff:
    AND FALSE FALSE =~> FALSE
  ```
]

#quiz(name: "Pairs")[
  Lets implement records by implementing the following API

  ```haskell

  let PAIR = \x1 x2 -> _______________________________________________

  let FST  = \p -> ___________________________________________________

  let SND  = \p -> ___________________________________________________

  eval pair_fst:
    fst (PAIR apple banana)   =~>   apple

  eval pair_fst:
    snd (PAIR apple banana)   =~>   banana
  ```

]

#pagebreak()

#quiz(name: "Zero")[

  Which of these is a valid encoding of `ZERO`?

  1. `let ZERO = \f x -> x`
  2. `let ZERO = \f x -> f`
  3. `let ZERO = \f x -> f x`
  4. `let ZERO = \x -> x`
  5. None of the above

]

#quiz(name: "Addition")[

  How shall we implement `ADD`?

  1. `let ADD = \n m -> n INC m`
  2. `let ADD = \n m -> INC n m`
  3. `let ADD = \n m -> n m INC`
  4. `let ADD = \n m -> n (m INC)`
  5. `let ADD = \n m -> n (INC m)`
]

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
