# SudokuSolverHS (07/2014)

This is a backtrack-sudoku-solver implemented in Haskell.

## Prerequisites

* Haskell (ghci/ghc)
* an unsolved sudoku

## How to use

Sudokus are of the type `List` of `List` of `Maybe Int`. Every line of the sudoku is a `List` of `Maybe Int`. Every free gap is `Nothing` and every composed number a `Just integer`-value.

The `solve Function` takes two values: a sudoku and a strategy.

There are two backtracking-strategies in this repository. One uses the first located emtpy field and fills it with any possible value (`getNextNothing). The second one uses the empty field with least alternatives first (`getBestNothing).

It contains also a TestSuite with an example-sudoku (testSudoku).

### run the solver with getNextNothing-strategy:
* solveChooseFirst testSudoku
### run the solver with getBestNothing-strategy:
* solveChooseBest testSudoku
### if you want to implement a new strategy
* type: `Sudoku -> Maybe ( Coordinate, [Int])`
* a strategy takes a unsolved sudoku and returns a `Just Coordinate` with a suggested substitutions or `Nothing`
* the returned `Coordinate` will be substituted next
* run it with `solve yourStrategy testSudoku`
