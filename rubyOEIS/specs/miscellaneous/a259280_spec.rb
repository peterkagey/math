require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a259280(n)
  end

  it "should know first sixteen values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 4
    expect(a(4)).to eq 5
    expect(a(5)).to eq 7
    expect(a(6)).to eq 9
    expect(a(7)).to eq 11
    expect(a(8)).to eq 14
    expect(a(9)).to eq 16
    expect(a(10)).to eq 19
    expect(a(11)).to eq 21
    expect(a(12)).to eq 24
    expect(a(13)).to eq 27
    expect(a(14)).to eq 30
    expect(a(15)).to eq 33
    expect(a(16)).to eq 36
  end

end
