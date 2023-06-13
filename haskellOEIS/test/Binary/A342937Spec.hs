module Binary.A342937Spec (main, spec) where
import Test.Hspec
import Binary.A342937 (a342937)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A342937" $
  it "correctly computes the first 20 elements" $
      map a342937 [1..20] `shouldBe` expectedValue where
        expectedValue = [2, 1, 8, 1, 3, 2, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7, 2, 1, 10, 1]
