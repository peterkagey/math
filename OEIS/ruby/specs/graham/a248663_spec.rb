require_relative '../../scripts/graham/a248663'

describe OEIS do

  def a(n)
    OEIS.a248663(n)
  end

  it "should handle a(1)" do
    expect(a(1)).to eq 0
  end

  it "should handle primes" do
    expect(a(2)).to eq 1
    expect(a(3)).to eq 2
    expect(a(5)).to eq 4
    expect(a(7)).to eq 8
  end

  it "should handle perfect squares" do
    expect(a(25)).to eq 0
    expect(a(36)).to eq 0
    expect(a(49)).to eq 0
  end

  it "should handle composites" do
    expect(a(6)).to eq 3
    expect(a(12)).to eq 2
    expect(a(2*3*5*7*7)).to eq 7
  end

end
