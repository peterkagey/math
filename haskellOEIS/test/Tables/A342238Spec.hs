module Tables.A342238Spec (main,spec) where
import Test.Hspec
import Tables.A342238 (a342238)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A342238" $
  it "correctly computes the first 20 elements" $
    take 20 (map a342238 [1..]) `shouldBe` expectedValue where
      expectedValue = [1,2,0,3,2,0,4,6,2,0,5,12,12,2,0,6,20,36,30,2]
