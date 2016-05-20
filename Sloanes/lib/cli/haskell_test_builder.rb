require_relative 'test_builder'

class HaskellTestBuilder < TestBuilder

  def test
    expect = range.map { |t| "#{a[t]}"}.join(",")
    @test ||=
%(module Tests.AlecSequences.A#{@sequence_number}Test where
import Test.Hspec
import AlecSequences.A#{@sequence_number} (a#{@sequence_number})
main :: IO ()

main = hspec $
  describe "A#{@sequence_number}" $
    it "correctly computes the first #{@number_of_terms} elements" $
      take #{@number_of_terms} (map a#{@sequence_number} [#{minimum_argument}..]) `shouldBe` expectedValue where
        expectedValue = [#{expect}]
)
# require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

# describe OEIS do

#   def a(n)
#     OEIS.a#{@sequence_number}(n)
#   end

#   it "should know first #{@number_of_terms} values" do
#     #{expect}
#   end

# end
# )
  end

end

HaskellTestBuilder.new(ARGV[0], ARGV[1], :haskell)
