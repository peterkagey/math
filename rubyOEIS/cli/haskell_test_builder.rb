require_relative 'test_builder'

class HaskellTestBuilder < TestBuilder

  def haskell_module_name
    pattern = /haskellOEIS\/src\/(.+?)\/A.+/
    module_name = sequence_path.match(pattern)[1]
    raise "Could not extract module name" if module_name.nil?
    module_name
  end

  def test
    expect = range.map { |t| "#{a[t]}"}.join(",")
    @test ||=
%(module #{haskell_module_name}.A#{@sequence_number}Spec (main, spec) where
import Test.Hspec
import #{haskell_module_name}.A#{@sequence_number} (a#{@sequence_number})

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A#{@sequence_number}" $
  it "correctly computes the first #{@number_of_terms} elements" $
    take #{@number_of_terms} (map a#{@sequence_number} [#{minimum_argument}..]) `shouldBe` expectedValue where
      expectedValue = [#{expect}]
)
  end

end

HaskellTestBuilder.new(ARGV[0], ARGV[1], :haskell)
