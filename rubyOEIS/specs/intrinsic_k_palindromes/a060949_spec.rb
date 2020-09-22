require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a060949(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 2049
    expect(a(2)).to eq 2145
    expect(a(3)).to eq 2193
    expect(a(4)).to eq 2289
    expect(a(5)).to eq 2313
  end

end
