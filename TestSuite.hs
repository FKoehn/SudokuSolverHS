module TestSuite where
import SudokuSolver
testSudoku :: Sudoku
testSudoku = [	[Just 1, Nothing, Just 4, Just 3, Just 7, Nothing, Nothing, Nothing, Nothing],
		[Nothing, Just 7, Nothing, Nothing, Nothing, Just 4, Nothing, Nothing, Nothing],
		[Nothing, Just 6, Just 2, Nothing, Just 8, Nothing, Nothing, Nothing, Nothing],
		[Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing],
		[Nothing, Nothing, Nothing, Nothing, Just 2, Just 7, Just 4, Just 9, Nothing],
		[Nothing, Nothing, Just 9, Nothing, Nothing, Nothing, Nothing, Just 1, Nothing],
		[Just 3, Nothing, Nothing, Just 9, Just 1, Nothing, Just 6, Nothing, Nothing],
		[Nothing, Just 2, Nothing, Nothing, Nothing, Nothing, Nothing, Just 8, Nothing],
		[Just 7, Nothing, Just 6, Just 8, Just 3, Nothing, Nothing, Just 2, Nothing]
		]
solution = [[[Just 1,Just 5,Just 4,Just 3,Just 7,Just 9,Just 8,Just 6,Just 2],
		[Just 8,Just 7,Just 3,Just 2,Just 6,Just 4,Just 9,Just 5,Just 1],
		[Just 9,Just 6,Just 2,Just 5,Just 8,Just 1,Just 7,Just 4,Just 3],
		[Just 2,Just 1,Just 7,Just 4,Just 9,Just 8,Just 5,Just 3,Just 6],
		[Just 6,Just 3,Just 5,Just 1,Just 2,Just 7,Just 4,Just 9,Just 8],
		[Just 4,Just 8,Just 9,Just 6,Just 5,Just 3,Just 2,Just 1,Just 7],
		[Just 3,Just 4,Just 8,Just 9,Just 1,Just 2,Just 6,Just 7,Just 5],
		[Just 5,Just 2,Just 1,Just 7,Just 4,Just 6,Just 3,Just 8,Just 9],
		[Just 7,Just 9,Just 6,Just 8,Just 3,Just 5,Just 1,Just 2,Just 4]]]

test = all (\t -> t testSudoku == solution) [ solveChooseFirst, solveChooseBest ]
