module Tables.A342381Spec (main, spec) where
import Test.Hspec
import Tables.A342381 (a342381)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A342381" $
  it "correctly computes the first 20 elements" $
    take 20 (map a342381 [0..]) `shouldBe` expectedValue where
      expectedValue = [1,1,1,5,2,1,29,15,3,1,233,116,30,4,1,2329,1165,290,50,5]
