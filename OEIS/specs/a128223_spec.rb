require_relative '../scripts/a128223'

#a(n) = if n mod 2 = 0 then n*(n+1)/2 otherwise (n+1)^2/2-1.
describe OEIS do

  def a(n)
    OEIS.a128223(n)
  end

  it "should handle small values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 3
    expect(a(3)).to eq 7
    expect(a(4)).to eq 10
  end

end