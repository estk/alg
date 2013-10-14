-- We want to calculate the largest positive difference between two elements in a list.
import Debug.Trace
import Test.QuickCheck
import System.Random


profit' :: [Int] -> Int
profit' = fst . (foldl helper' (0,0)) . reverse

helper' a@(maxdiff, max) x | max < x = (maxdiff, x)
                     | maxdiff < diff = (diff, max)
                     | otherwise = a
    where diff = max - x

profit :: [Int] -> Int
profit [] = 0
profit l = maximum $ map (flip helper $ l) l

helper x l = maximumOr 0 $ map (\y -> y-x) $ dropWhile (/= x) l
    where maximumOr a [] = a
          maximumOr _ l = maximum l

prop_same :: [Positive Int] -> Bool
prop_same s = (profit l) == (profit' l)
  where l = map getPositive s

-- newtype Pos = Pos Int
--   deriving (Show, Random)
--  (Pos x) = x
-- 
-- instance Arbitrary Pos where
--   arbitrary = do
--     choose (Pos 0, Pos 1000)
