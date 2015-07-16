require_relative '../../scripts/helpers/prime_factors_hash'

describe "prime_factors_hash" do
  it "should handle small values" do
    expect(prime_factors(1)).to eq({})
    expect(prime_factors(2)).to eq({2=>1})
    expect(prime_factors(2**4 * 5**3)).to eq({2=>4, 3=>0, 5=>3})
  end
end