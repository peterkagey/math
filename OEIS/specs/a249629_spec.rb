require_relative '../scripts/a249629'
# A249629: Number of strings of length n over a 4 letter alphabet that begin
# with a nontrivial palindrome.
# a(0) = 0; a(1) = 0; a(n+1) = 4*a(n) + 4^ceil(n/2) - a(ceil(n/2))

describe OEIS do

  def a(n)
    OEIS.a249629(n)
  end

  it "should handle a(1)" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 4
    expect(a(3)).to eq 28
    expect(a(4)).to eq 124
  end

end