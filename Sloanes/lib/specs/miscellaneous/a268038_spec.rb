require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a268038(n)
  end

  it "should know first fourteen values" do
    expect(a(1)).to eq 0
    expect(a(2)).to eq 0
    expect(a(3)).to eq -1
    expect(a(4)).to eq -1
    expect(a(5)).to eq -1
    expect(a(6)).to eq 0
    expect(a(7)).to eq 1
    expect(a(8)).to eq 1
    expect(a(9)).to eq 1
    expect(a(10)).to eq 1
    expect(a(11)).to eq 0
    expect(a(12)).to eq -1
    expect(a(13)).to eq -2
    expect(a(14)).to eq -2
  end

end












