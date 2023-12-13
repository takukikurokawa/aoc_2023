-- AoC Day8 Part2 (Brute Force)
import Data.List.Split (splitOn)
import Data.Map
import Data.Typeable
import Debug.Trace
import System.IO (isEOF)

readLines :: IO [String]
readLines = do
    eof <- isEOF
    if eof
        then return []
        else do
            l <- getLine
            t <- readLines
            return $ l : t

parseLeft :: String -> (String, String)
parseLeft s = case splitOn " = " s of
    [x, y] -> case splitOn ", " (init (tail y)) of
        [l, _] -> (x, l)
        _      -> error "invalid input"
    _      -> error "invalid input"

createLeftMap :: [String] -> Map String String
createLeftMap = fromList . Prelude.map parseLeft

parseRight :: String -> (String, String)
parseRight s = case splitOn " = " s of
    [x, y] -> case splitOn ", " (init (tail y)) of
        [_, r] -> (x, r)
        _      -> error "invalid input"
    _      -> error "invalid input"

createRightMap :: [String] -> Map String String
createRightMap = fromList . Prelude.map parseRight

getMapValue :: String -> Map String String -> String
getMapValue v m = 
    case Data.Map.lookup v m of
        Just value -> value
        Nothing    -> error "unknown"

moveOne :: String -> Char -> Map String String -> Map String String -> String
moveOne v c l r
    | c == 'L' = getMapValue v l
    | c == 'R' = getMapValue v r

moveAll :: [String] -> Char -> Map String String -> Map String String -> [String]
moveAll v c l r = Prelude.map (\x -> moveOne x c l r) v

dfs :: (Int, [String], String, Map String String, Map String String) -> Int
dfs (i, v, s, l, r) =
    let to = moveAll v (s !! (mod i (length s))) l r
    in if all (\x -> last x == 'Z') to
        then i
    else if i <= 100
        then trace((show v) ++ " " ++ (show to) ++ " " ++ (show (s !! (mod i (length s)))) ++ " " ++ (show i)) dfs (i + 1, to, s, l, r)
    else if i > 2000000000
        then error "e"
    else if (mod i 1000000) == 0
        then trace (show i) dfs (i + 1, to, s, l, r)
        else dfs (i + 1, to, s, l, r)

main :: IO ()
main = do
    s <- getLine
    _ <- getLine
    t <- readLines
    let l = createLeftMap t
    let r = createRightMap t
    let b = Prelude.map (Prelude.take 3) t
    let a = Prelude.filter (\x -> last x == 'A') b
    putStrLn $ show (dfs (0, a, s, l, r) + 1)
