import Data.String

main :: IO ()
main = interact (show . rmps . read)

rmps :: [Int] -> Int
rmps [] = error "Has to be non null!"
rmps [x] = x
rmps (x:xs) = snd $ foldl f (x, x) xs
    where f (sum, maxsum) x = ( sum+x, (sum+x) `max` maxsum )
