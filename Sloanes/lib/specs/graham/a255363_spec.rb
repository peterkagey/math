require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a255363(n)
  end

  it "should handle small values" do
    expect(a(1)).to eq 5
    expect(a(2)).to eq 7
    expect(a(3)).to eq 11
    expect(a(4)).to eq 13
    expect(a(5)).to eq 14
  end

end
