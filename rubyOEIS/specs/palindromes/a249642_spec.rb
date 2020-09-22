require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a249642(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 9
    expect(a(3)).to eq 153
    expect(a(4)).to eq 1449
  end

end
