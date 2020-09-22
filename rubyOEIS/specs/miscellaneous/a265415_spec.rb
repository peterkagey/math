require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a265415(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 10
    expect(a(3)).to eq 21
    expect(a(4)).to eq 31
    expect(a(5)).to eq 37
  end

end
