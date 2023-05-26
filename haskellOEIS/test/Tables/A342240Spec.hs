module Tables.A342240Spec (main,spec) where
import Test.Hspec
import Tables.A342240 (a342240)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A342240" $
  it "correctly computes the first 20 elements" $
    take 20 (map a342240 [1..]) `shouldBe` expectedValue where
      expectedValue = [0,0,1,0,2,1,0,3,4,1,0,4,9,10,1,0,5,16,33,20]
