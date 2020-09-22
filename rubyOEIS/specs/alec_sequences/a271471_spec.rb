require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a271471(n)
  end

  it "should know first 5 values" do
    expect(a(1)).to eq 5
    expect(a(2)).to eq 17
    expect(a(3)).to eq 28
    expect(a(4)).to eq 37
    expect(a(5)).to eq 82
  end

end
