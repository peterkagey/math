require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a060877(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 65
    expect(a(2)).to eq 73
    expect(a(3)).to eq 85
    expect(a(4)).to eq 93
    expect(a(5)).to eq 99
  end

end
