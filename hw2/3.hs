import Data.List
import Data.Function
import Test.QuickCheck

algWrap :: [(Int,Int)] -> (Int, [(Int,Int)])
algWrap [] = (0,[])
algWrap l = maxFT . alg $ l

alg :: [(Int,Int)] -> [(Int,Int)]
alg = reverse . sortBy (compare `on` snd)

maxF :: [(Int,Int)] -> Int
maxF = maximum . snd . foldl f (0, [])
    where f (start, acc) (d,t) = (start + d, acc ++ [start + d+t])

bruteForce :: [(Int,Int)] -> (Int, [(Int,Int)])
bruteForce [] = (0, [])
bruteForce l = head . sortBy (compare `on` fst) . map maxFT . permutations $ l

maxFT x = (maxF x, x)

prop_same :: [(Positive Int, Positive Int)] -> Bool
prop_same ns = (fst $ bruteForce l) == (fst $ algWrap l)
    where l = map (\(x,y) -> (getPositive x, getPositive y)) ns

qcargs = f stdArgs
    where f (Args r mSu mD mSi _) = (Args r mSu 1 12 True)
