import Data.List (findIndices, permutations)
import Helpers.ListHelpers (cartesianProduct)
wreathProductElements k n = [(a, b) | a <- permutations [0..n-1], b <- cartesianProduct n [0..k-1]]

isDerangement (perm, prod) = all (\fp -> (prod !! fp) /= 0) fixedPoints where
    fixedPoints = findIndices (uncurry (==)) $ zip perm [0..]
