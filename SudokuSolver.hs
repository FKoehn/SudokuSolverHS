module SudokuSolver where

import Data.Maybe
import Data.List
import Data.Tuple

-- sudoku-solver using backtracking (depth-first-search)

type Sudoku = [[Maybe Int]]
type Coordinate = (Int, Int)
type SolveStrategy = Sudoku -> Maybe ( Coordinate, [Int])

-- size x size boxes, 3 is standard for newspaper-sudokus
size :: Int
size = 3

-- range of usable numbers
range :: [Int]
range = [1..size^2]

-- addressable range (fields are zero-based)
coorRange :: [Int]
coorRange = [0..(size^2-1)]

-- sudoku solver using given strategy
solve :: SolveStrategy -> Sudoku -> [Sudoku]
solve strategy sudoku = case next of
				Nothing -> [sudoku]
				Just (c, subs) ->  concat $ map (\ s -> solve strategy (substituteNothing sudoku c (Just s))) subs
				where
				next = strategy sudoku

-- sudoku solver filling first empty field
solveChooseFirst :: Sudoku -> [Sudoku]
solveChooseFirst = solve getNextNothing

-- sudoku solver filling empty field with least alternatives
solveChooseBest :: Sudoku -> [Sudoku]
solveChooseBest = solve getBestNothing

-- simple strategy returning first empty field with suggestion
getNextNothing :: SolveStrategy
getNextNothing sudoku = case firstIndex of
			Nothing -> Nothing
			Just i  -> Just (( head $ allIndices !! i, i), getPossibleSubstitutions sudoku ( head $ allIndices !! i, i))
			where 
			allIndices = map (\row -> elemIndices Nothing row) sudoku
			firstIndex = safeHead $ findIndices (\a -> length a > 0) $ allIndices

-- strategy returning empty field with least alternatives with suggestion
getBestNothing :: SolveStrategy
getBestNothing sudoku = safeHead sortedNothings
			where
			allCoordinates = concat $ map (\i -> map (\ j -> (i,j) ) coorRange) coorRange
			nothingCoordinates = filter (\ (x,y) -> ((sudoku !! y) !! x) == Nothing ) allCoordinates
			sortedNothings = sortBy sortByLength $ map (\ c -> ( c ,getPossibleSubstitutions sudoku c )) nothingCoordinates

sortByLength :: (Coordinate, [Int]) -> (Coordinate, [Int]) -> Ordering
sortByLength (_, a1) (_, a2)
  	| length a1 < length a2 = LT
  	| length a1 > length a2 = GT
  	| length a1 == length a2 = EQ

safeHead :: [a] -> Maybe a
safeHead a = case a of
	     [] 	-> Nothing
	     (head:_)	-> Just head

-- substitute empty field with given value
substituteNothing :: Sudoku -> Coordinate -> Maybe Int -> Sudoku
substituteNothing sudoku c subst = fst outerSplit ++ [fst innerSplit ++ [subst] ++ tail (snd innerSplit)] ++ tail (snd  outerSplit)
				   where
				   outerSplit = splitAt (snd c) sudoku
				   innerSplit = splitAt (fst c) $ head (snd outerSplit)

-- returns possible substitutions for given empty field
getPossibleSubstitutions :: Sudoku -> Coordinate -> [Int]
getPossibleSubstitutions sudoku (x,y) = (range \\ (getRowNumbers y sudoku)) `intersect` (range \\ (getColumnNumbers x sudoku)) `intersect` (range \\ (getBoxNumbers (x `quot` size) (y `quot` size) sudoku))


getBoxNumbers :: Int -> Int -> Sudoku -> [Int]
getBoxNumbers c r sudoku = createNumberList $ foldr (++) [] $ map (\ a -> take size $ drop ((c)*size) a) $ take size $ drop ((r)*size) sudoku

getRowNumbers :: Int -> Sudoku -> [Int]
getRowNumbers row sudoku = createNumberList $ sudoku !! row

getColumnNumbers :: Int -> Sudoku -> [Int]
getColumnNumbers column sudoku = createNumberList $ map (\a -> a !! column) sudoku 

createNumberList :: [Maybe Int] -> [Int]
createNumberList list = concat $ map getNumber list

getNumber :: Maybe Int -> [Int]
getNumber i = case i of
		Just i' -> [i']
		Nothing -> []
