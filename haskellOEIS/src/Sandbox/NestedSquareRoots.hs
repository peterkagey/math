import Math.NumberTheory.Powers.Squares (exactSquareRoot)
import Data.Foldable
import Helpers.ListHelpers (cartesianProduct)

g :: (Foldable t, Integral b) => t b -> Maybe b
g = foldl f (Just 0)

-- f ::
f a2 a1 = exactSquareRoot =<< fmap (+a1) a2

flatMap f = concatMap (Data.Foldable.toList . f)
