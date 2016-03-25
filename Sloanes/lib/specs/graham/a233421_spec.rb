require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a233421(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 6
    expect(a(2)).to eq 8
    expect(a(3)).to eq 10
    expect(a(4)).to eq 12
    expect(a(5)).to eq 14
  end

end
