require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a268403(n)
  end

  it "should know first 20 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 3
    expect(a(3)).to eq 9
    expect(a(4)).to eq 19
    expect(a(5)).to eq 41
    expect(a(6)).to eq 71
    expect(a(7)).to eq 113
    expect(a(8)).to eq 171
    expect(a(9)).to eq 241
    expect(a(10)).to eq 319
    expect(a(11)).to eq 401
    expect(a(12)).to eq 503
    expect(a(13)).to eq 633
    expect(a(14)).to eq 823
    expect(a(15)).to eq 1033
    expect(a(16)).to eq 1343
    expect(a(17)).to eq 1673
    expect(a(18)).to eq 2031
    expect(a(19)).to eq 2413
    expect(a(20)).to eq 2855
  end

end
