require_relative '../scripts/a254128'

describe OEIS do

  def a(n)
    OEIS.a254128(n)
  end

  it "should handle a(1)" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 0
    expect(a(3)).to eq 4
    expect(a(4)).to eq 8
    expect(a(5)).to eq 20
    expect(a(6)).to eq 40
  end

  it "should know that a(2k) = 2*a(2k-1)" do
    (1..5).each do |i|
      k = 2*i
      expect(a(k)).to eq 2*a(k-1)
    end
  end

end