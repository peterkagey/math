require_relative '../../scripts/intrinsic_k_palindromes/a060879'

describe OEIS do

  def a(n)
    OEIS.a060879(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 257
    expect(a(2)).to eq 273
    expect(a(3)).to eq 297
    expect(a(4)).to eq 313
    expect(a(5)).to eq 325
  end

end
