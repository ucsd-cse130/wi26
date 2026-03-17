#import "@preview/sheetstorm:0.4.0": *

#let quiz(name: none, ..args, body) = task(task-prefix: "Quiz", name: name, ..args, body)

#show: assignment.with(
  course: smallcaps[CSE 130 Winter 2026],
  title: "Worksheet 10B",
  authors: (
    (name: "NAME: _________________________ ", id: "SID: _________________________________"),
  ),
  info-box-enabled: false,
  score-box-enabled: false,
  date: datetime(year: 2026, month: 3, day: 12),
)

#quiz(name: "Combine")[

  Lets write a program that prints multiple things. What is the *type of* `combine`?

  ```haskell
  main :: IO ()
  main = combine (putStrLn "Hello,") (putStrLn "World!")

  -- putStrLn :: String -> Recipe ()

  -- combine  :: ______________________________________________________________
  ```
]



#quiz(name: "Combine With Result")[


  Suppose you have two recipes

  ```haskell
  crack     :: Recipe Yolk
  eggBatter :: Yolk -> Recipe Batter
  ```

  and we want to get

  ```haskell
  mkBatter :: Recipe Batter
  mkBatter = combineWithResult crack eggBatter
  ```

  What must the type of `combineWithResult` be?

  ```haskell
  combineWithResult  :: ______________________________________________________________
  ```
]

#quiz(name: "Repeat!")[

  Modify the code below so that it asks for your name and greets *repeatedly*, _until_
  the user enters `"QUIT"`.

  ```haskell
  main :: Recipe ()
  main = do
    name <- getLine

    ______________________________________________________________

              putStrLn ("Hello, " ++ name ++ "!")

    ______________________________________________________________
  ```

]

#quiz(name: "Your turn!")[

  What is something you found confusing in today's lecture (or earlier)?

  #rect(width: 100%, height: 5cm, stroke: 0.5pt)
]
