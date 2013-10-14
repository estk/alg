{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Test.QuickCheck
import System.Random
import Debug.Trace

cirmax :: [Int] -> Int
cirmax [] = error "No max of an empty list!"
cirmax [x] = x
cirmax l | (head xs) > (head ys) = cirmax xs
         | otherwise = cirmax ys
    where (xs, ys) = splitAt (quot (length l) 2) l

prop_ismax :: CycledList SmallInt -> Bool
prop_ismax s = if l == []
                 then True
                 else (maximum l) == (cirmax l)
    where l = map getInt $ getCycled s

newtype SmallInt = SmallInt {getInt :: Int}
  deriving (Eq, Ord, Show, Num, Random)

instance Arbitrary SmallInt where
  arbitrary = do
    choose (-100,100)

newtype CycledList a = Cycled {getCycled :: [a]}
  deriving (Eq, Ord, Show)

instance (Ord a, Arbitrary a) => Arbitrary (CycledList a) where
  arbitrary = do
    n <- arbitrary
    l <- arbitrary
    fmap Cycled $ fmap (rotate n) (return $ getOrdered l) 

rotate :: Int -> [a] -> [a]
rotate _ [] = []
rotate n xs = zipWith const (drop n $ cycle xs) xs

qcargs = Args {replay=Nothing, maxSuccess=50, maxDiscardRatio=1, maxSize=50, chatty=True}
