module HelperSequences.A001227Spec (main, spec) where
import Test.Hspec
import HelperSequences.A001227 (a001227)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A001227" $
  it "correctly computes the first 20 elements" $
    take 20 (map a001227 [1..]) `shouldBe` expectedValue where
      expectedValue = [1, 1, 2, 1, 2, 2, 2, 1, 3, 2, 2, 2, 2, 2, 4, 1, 2, 3, 2, 2]
