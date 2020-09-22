require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a000045(n)
  end

  it "should know first 10 values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 1
    expect(a(3)).to eq 2
    expect(a(4)).to eq 3
    expect(a(5)).to eq 5
    expect(a(6)).to eq 8
    expect(a(7)).to eq 13
    expect(a(8)).to eq 21
    expect(a(9)).to eq 34
  end

end
