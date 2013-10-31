groupMax :: Int -> [Int] -> [[Int]]
groupMax max = reverse . listify . foldl f ([], [])
    where f (out, cur) x | x + (sum cur) > max = ((reverse cur):out, [x])
                         | otherwise = (out, x:cur)
          listify (x,y) = (reverse y):x 

gMax :: Int -> [Int] -> [[Int]]
gMax max = reverse . foldl f [[]]
    where f out x | x + (sum $ head out) > max = [x]:out
                  | otherwise = (head out ++ [x]):(tail out)



