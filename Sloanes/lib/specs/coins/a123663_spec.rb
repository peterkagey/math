require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a123663(n)
  end

  it "should know that a single square doesn't connect" do
    expect(a(1)).to eq 0
  end

  it "should about small numbers of squares" do
    expect(a(2)).to eq 1
    expect(a(3)).to eq 2
    expect(a(4)).to eq 4
    expect(a(5)).to eq 5
    expect(a(6)).to eq 7
  end

  it "should handle perfect squares" do
    expect(a(5**2)).to eq 2*(4*5)
    expect(a(10**2)).to eq 2*(9*10)
  end

  it "should handle non-square composites" do
    expect(a(919)).to eq 1777
    expect(a(150)).to eq 275
  end

end
