module Tables.A342237Spec (main, spec) where
import Test.Hspec
import Tables.A342237 (a342237)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A342237" $
  it "correctly computes the first 20 elements" $
    take 20 (map a342237 [1..]) `shouldBe` expectedValue where
      expectedValue = [0,0,1,0,2,1,0,3,6,1,0,4,15,14,1,0,5,28,51,30]
