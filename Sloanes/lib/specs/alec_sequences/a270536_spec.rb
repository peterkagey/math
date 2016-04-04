require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a270536(n)
  end

  it "should know first 20 values" do
    expect(a(1)).to eq 0
    expect(a(2)).to eq 0
    expect(a(3)).to eq 0
    expect(a(4)).to eq 6
    expect(a(5)).to eq 0
    expect(a(6)).to eq 15
    expect(a(7)).to eq 6
    expect(a(8)).to eq 22
    expect(a(9)).to eq 28
    expect(a(10)).to eq 45
    expect(a(11)).to eq 33
    expect(a(12)).to eq 66
    expect(a(13)).to eq 35
    expect(a(14)).to eq 64
    expect(a(15)).to eq 74
    expect(a(16)).to eq 104
    expect(a(17)).to eq 102
    expect(a(18)).to eq 140
    expect(a(19)).to eq 129
    expect(a(20)).to eq 160
  end

end
