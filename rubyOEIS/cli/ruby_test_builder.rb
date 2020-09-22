require_relative 'test_builder'

class RubyTestBuilder < TestBuilder

  def test
    expect = range.map { |t| "expect(a(#{t})).to eq #{a[t]}"}.join("\n    ")
    @test ||=
%(require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a#{@sequence_number}(n)
  end

  it "should know first #{@number_of_terms} values" do
    #{expect}
  end

end
)
  end

end

RubyTestBuilder.new(ARGV[0], ARGV[1], :ruby)
