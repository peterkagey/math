require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a169849(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 9
    expect(a(2)).to eq 3
    expect(a(3)).to eq 6
    expect(a(4)).to eq 2
    expect(a(5)).to eq 4
  end

end
