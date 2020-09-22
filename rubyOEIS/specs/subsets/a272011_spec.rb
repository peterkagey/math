require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272011(n)
  end

  it "should know first 30 values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 1
    expect(a(3)).to eq 0
    expect(a(4)).to eq 2

    expect(a(25)).to eq 3
    expect(a(26)).to eq 2
    expect(a(27)).to eq 1
    expect(a(28)).to eq 3
    expect(a(29)).to eq 2
    expect(a(30)).to eq 1
  end

end
