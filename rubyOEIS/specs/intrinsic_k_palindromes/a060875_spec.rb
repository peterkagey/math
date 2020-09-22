require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a060875(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 17
    expect(a(2)).to eq 21
    expect(a(3)).to eq 27
    expect(a(4)).to eq 31
    expect(a(5)).to eq 82
  end

end
