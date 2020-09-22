require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a143481(n)
  end

  it "should know first ten values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 6
    expect(a(4)).to eq 8
    expect(a(5)).to eq 20
    expect(a(6)).to eq 24
    expect(a(7)).to eq 42
    expect(a(8)).to eq 48
    expect(a(9)).to eq 54
    expect(a(10)).to eq 64
  end

end
