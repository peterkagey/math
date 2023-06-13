module FindStat.A349106Spec (main, spec) where
import Test.Hspec
import FindStat.A349106 (a349106)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A349106" $
  it "correctly computes the first 20 elements" $
    take 20 (map a349106 [0..]) `shouldBe` expectedValue where
      expectedValue = [1, 1, 2, 5, 1, 15, 8, 1, 52, 51, 16, 1, 203, 312, 172, 32, 1, 877, 1926, 1611]
