module HelperSequences.A024493Spec (main, spec) where
import Test.Hspec
import HelperSequences.A024493 (a024493)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A024493" $
  it "correctly computes the first 20 elements" $
    take 20 (map a024493 [0..]) `shouldBe` expectedValue where
      expectedValue = [1, 1, 1, 2, 5, 11, 22, 43, 85, 170, 341, 683, 1366, 2731, 5461, 10922, 21845, 43691, 87382, 174763]
