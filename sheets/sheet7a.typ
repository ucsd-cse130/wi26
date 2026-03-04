#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 7A",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 2, day: 17),
)

#quiz(name: "Let-Bindings")[
  What _should_ the following expression evaluate to?

  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      ```haskell
      quiz = let x = 0
             in
               let x = 100
               in
                 x + 1

      -- >>> quiz
      _________________________________
      ```
    ],
    [
      ```haskell
        quiz = let x = 0
               in
                 (let x = 100
                  in
                    x + 1
                 )
                 +
                 x

        -- >>> quiz
        _________________________________
      ```
    ],
  )
]

#quiz(name: "Let and Environments")[

  What _should_ the `env` be?

  #grid(
    columns: (1fr, 1fr, 1fr),
    inset: 0.5em,
    stroke: 0.5pt,
    [
      ```haskell
                    -- env
      let x = 0
      in            -- ________
        x + 1
      ```
    ],
    [
      ```haskell
                    -- env
      let x = 0
      in            -- _________
        let y = 100
        in          -- _________
          x + y

      ```
    ],
    [
      ```haskell
                   -- env
      let x = 0
      in           -- ___________
        let x = 100
        in         -- ___________
          x + 1

      ```
    ],
  )

]


#quiz(name: "Free Variables")[

  Circle the variables that *occur free* in the expression?

  ```haskell
  let y = (let x = 2
           in x      ) + x
  in
    let x = 3
    in
      x + y
  ```
]

#quiz(name: "Lambdas with Free Variables")[
  What should the following two expressions evaluate to?

  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      ```haskell
      quiz =
        let c = 1
        in
           let inc = \x -> x + c
           in
              inc 10

      -- >>> quiz

      ______________________________________
      ```
    ],
    [
      ```haskell
      let c = 1
      in
         let inc = \x -> x + c
         in
            let c = 100
            in
              inc 10

      -- >>> quiz

      ______________________________________
      ```
    ],
  )

]

#pagebreak()

#quiz(name: "Creating Lambdas")[

  What should the following evaluate to?

  ```haskell
  quiz =
    let add = \x -> (\y -> x + y)
    in
      let add10 = add 10
      in
        let add20 = add 20
        in
          (add10 100) + (add20 1000)

  -- >>> quiz

  ______________________________________
  ```
]

#quiz(name: "Your turn!")[

  What is something you are confused by in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
