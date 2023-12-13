-- AoC Day8 Part1
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

move :: String -> Char -> Map String String -> Map String String -> String
move v c l r
    | c == 'L' = getMapValue v l
    | c == 'R' = getMapValue v r

dfs :: (Int, String, String, Map String String, Map String String) -> Int
dfs (i, v, s, l, r) =
    let to = move v (s !! (mod i (length s))) l r
    in if to == "ZZZ"
        then i
        else dfs (i + 1, to, s, l, r)
    -- else if i <= 400
    --     then trace (v ++ " " ++ to ++ " " ++ show (s !! (mod i (length s))) ++ " " ++ show i) dfs (i + 1, to, s, l, r)

main :: IO ()
main = do
    s <- getLine
    _ <- getLine
    t <- readLines
    let l = createLeftMap t
    let r = createRightMap t
    putStrLn $ show (dfs (0, "AAA", s, l, r) + 1)

-- printKeyValuePair :: (String, String) -> IO ()
-- printKeyValuePair (key, value) = putStrLn $ "Key: " ++ key ++ ", Value: " ++ value
