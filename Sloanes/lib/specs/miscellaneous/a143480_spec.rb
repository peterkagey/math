require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a143480(n)
  end

  it "should know first ten values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 4
    expect(a(3)).to eq 9
    expect(a(4)).to eq 16
    expect(a(5)).to eq 25
    expect(a(6)).to eq 72
    expect(a(7)).to eq 49
    expect(a(8)).to eq 104
    expect(a(9)).to eq 81
    expect(a(10)).to eq 160
  end

end
