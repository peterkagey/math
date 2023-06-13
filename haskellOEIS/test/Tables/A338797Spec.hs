module Tables.A338797Spec (main, spec) where
import Test.Hspec
import Tables.A338797 (a338797)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A338797" $
  it "correctly computes the first 20 elements" $
    take 20 (map a338797 [1..]) `shouldBe` expectedValue where
      expectedValue = [1, 2, 1, 3, 6, 1, 4, 4, 12, 1, 5, 10, 15, 20, 1, 6, 3, 2, 12, 30]
