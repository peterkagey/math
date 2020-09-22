require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272035(n)
  end

  it "should know first 6 values" do
    expect(a(1)).to eq 0
    expect(a(2)).to eq 1
    expect(a(3)).to eq 38
    expect(a(4)).to eq 39
    expect(a(5)).to eq 2090
    expect(a(6)).to eq 2091
  end

end
