require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a254733(n)
  end

  it "should handle a(1)" do
    expect(a(1)).to eq 2
    expect(a(2)).to eq 4
    expect(a(3)).to eq 6
    expect(a(4)).to eq 6
  end

end
