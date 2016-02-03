require_relative '../../scripts/helpers/prime_factors'

describe PrimeFactors do
  it "should handle small values" do
    expect(PrimeFactors.hash(1)).to eq({})
    expect(PrimeFactors.hash(2)).to eq({2=>1})
    expect(PrimeFactors.hash(2**4 * 5**3)).to eq({2=>4, 3=>0, 5=>3})
  end
end
