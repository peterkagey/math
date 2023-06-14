module FindStat.A346462Spec (main, spec) where
import Test.Hspec
import FindStat.A346462 (a346462)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A346462" $
  it "correctly computes the first 20 elements" $
    take 20 (map a346462 [0..]) `shouldBe` expectedValue where
      expectedValue = [1, 1, 0, 0, 0, 2, 0, 0, 4, 2, 2, 0, 10, 4, 8, 14, 0, 40, 10, 42]
