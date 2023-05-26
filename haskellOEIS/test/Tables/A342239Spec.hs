module Tables.A342239Spec (main,spec) where
import Test.Hspec
import Tables.A342239 (a342239)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A342239" $
  it "correctly computes the first 20 elements" $
    take 20 (map a342239 [1..]) `shouldBe` expectedValue where
      expectedValue = [1,2,0,3,2,0,4,6,4,0,5,12,18,6,0,6,20,48,48,12]
