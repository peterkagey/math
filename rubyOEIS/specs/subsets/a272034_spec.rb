require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272034(n)
  end

  it "should know first 18 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 4
    expect(a(4)).to eq 8
    expect(a(5)).to eq 16
    expect(a(6)).to eq 32
    expect(a(7)).to eq 36
    expect(a(8)).to eq 38
    expect(a(9)).to eq 64
    expect(a(10)).to eq 128
    expect(a(11)).to eq 256
    expect(a(12)).to eq 512
    expect(a(13)).to eq 1024
    expect(a(14)).to eq 2048
    expect(a(15)).to eq 2056
    expect(a(16)).to eq 2080
    expect(a(17)).to eq 2088
    expect(a(18)).to eq 2090
  end

end
