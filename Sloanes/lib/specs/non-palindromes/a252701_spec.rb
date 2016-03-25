require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a252701(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 8
    expect(a(2)).to eq 56
    expect(a(3)).to eq 392
    expect(a(4)).to eq 3080
  end

end
