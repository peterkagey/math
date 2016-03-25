require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a060876(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 33
    expect(a(2)).to eq 45
    expect(a(3)).to eq 51
    expect(a(4)).to eq 63
    expect(a(5)).to eq 244
  end

end
