require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n, opts = {})
    OEIS.a006255(n, opts)
  end

  it "should handle small values" do
    # pending("")
    expect(a(1)).to eq 1
    expect(a(2)).to eq 6
    expect(a(3)).to eq 8
    expect(a(4)).to eq 4
    expect(a(5)).to eq 10
    expect(a(6)).to eq 12
  end

  it "should handle perfect squares" do
    expect(a(9, seq:true)).to eq [9]
    expect(a(9)).to eq 9
  end

  it "should handle primes" do
    expect(a(13, seq:true)).to eq [13, 18, 26]
    expect(a(17, seq:true)).to eq [17, 32, 34]
    expect(a(19, seq:true)).to eq [19, 32, 38]
    expect(a(37, seq:true)).to eq [37, 72, 74]
  end

  it "should handle highly composite numbers" do
    expect(a(120)).to eq 135
  end

end
