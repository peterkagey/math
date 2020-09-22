require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    # A072905: Least k > n such that k*n is a square.
    OEIS.a072905(n)
  end

  it "should handle a(1)" do
    expect(a(1)).to eq 4
  end

  it "should handle squarefree numbers" do
    expect(a(2)).to eq 8
    expect(a(3)).to eq 12
    expect(a(5)).to eq 20
    expect(a(6)).to eq 24
  end

  it "should handle square numbers" do
    expect(a(4)).to eq 9
    expect(a(9)).to eq 16
    expect(a(16)).to eq 25
  end

  it "should handle numbers that are not square or squarefree" do
    expect(a(12)).to eq 27
    expect(a(2*3*5*7*7)).to eq 1920
  end

end
