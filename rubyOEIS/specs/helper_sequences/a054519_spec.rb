require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a054519(n)
  end

  it "should know first 10 values" do
    expect(a(0)).to eq 1
    expect(a(1)).to eq 2
    expect(a(2)).to eq 4
    expect(a(3)).to eq 6
    expect(a(4)).to eq 9
    expect(a(5)).to eq 11
    expect(a(6)).to eq 15
    expect(a(7)).to eq 17
    expect(a(8)).to eq 21
    expect(a(9)).to eq 24
  end

end
