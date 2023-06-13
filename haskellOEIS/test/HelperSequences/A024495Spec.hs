module HelperSequences.A024495Spec (main, spec) where
import Test.Hspec
import HelperSequences.A024495 (a024495)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A024495" $
  it "correctly computes the first 20 elements" $
    take 20 (map a024495 [0..]) `shouldBe` expectedValue where
      expectedValue = [0, 0, 1, 3, 6, 11, 21, 42, 85, 171, 342, 683, 1365, 2730, 5461, 10923, 21846, 43691, 87381, 174762]
