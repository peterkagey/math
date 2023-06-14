module FindStat.A346492Spec (main, spec) where
import Test.Hspec
import FindStat.A346492 (a346492)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A346492" $
  it "correctly computes the first 20 elements" $
    take 20 (map a346492 [1..]) `shouldBe` expectedValue where
      expectedValue = [1, 1, 1, 4, 0, 2, 15, 2, 1, 6, 76, 8, 8, 4, 24, 455, 40, 40, 45, 20]
