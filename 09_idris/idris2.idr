-- AoC Day9 Part2
module Main

import Data.List
import Data.Maybe
import Data.String
import Debug.Trace

toInt : String -> Int
toInt s = cast s

readLines : IO (List (List Int))
readLines = do
    l <- getLine
    case l of
        "" => pure []
        _  => do
            let a = map toInt (words l)
            t <- readLines
            pure (a :: t)

calcDifference : List Int -> List Int
calcDifference a = case a of
    []           => []
    head :: rest => zipWith (-) rest a

allEqual : List Int -> Bool
allEqual a = length (nub a) <= 1

firstElem : List Int -> Int
firstElem []       = 0
firstElem [x]      = x
firstElem (x :: _) = x

solve : List Int -> Int
solve a =
    let d = calcDifference a
    in if all (\x => x == 0) d
        then firstElem a
        else (firstElem a) - (solve d)

main : IO ()
main = do
    t <- readLines
    printLn (sum (map solve t))
