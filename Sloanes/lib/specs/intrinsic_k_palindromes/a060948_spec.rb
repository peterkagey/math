require_relative '../../scripts/intrinsic_k_palindromes/a060948'

describe OEIS do

  def a(n)
    OEIS.a060948(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 1025
    expect(a(2)).to eq 1057
    expect(a(3)).to eq 1105
    expect(a(4)).to eq 1137
    expect(a(5)).to eq 1161
  end

end
