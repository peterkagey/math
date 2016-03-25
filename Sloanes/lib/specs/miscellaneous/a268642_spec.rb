require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a268642(n)
  end

  it "should know first 30 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 3
    expect(a(3)).to eq 2
    expect(a(4)).to eq 6
    expect(a(5)).to eq 18
    expect(a(6)).to eq 9
    expect(a(7)).to eq 5
    expect(a(8)).to eq 15
    expect(a(9)).to eq 8
    expect(a(10)).to eq 4
    expect(a(11)).to eq 12
    expect(a(12)).to eq 36
    expect(a(13)).to eq 108
    expect(a(14)).to eq 54
    expect(a(15)).to eq 27
    expect(a(16)).to eq 14
    expect(a(17)).to eq 7
    expect(a(18)).to eq 21
    expect(a(19)).to eq 11
    expect(a(20)).to eq 33
    expect(a(21)).to eq 17
    expect(a(22)).to eq 51
    expect(a(23)).to eq 26
    expect(a(24)).to eq 13
    expect(a(25)).to eq 39
    expect(a(26)).to eq 20
    expect(a(27)).to eq 10
    expect(a(28)).to eq 30
    expect(a(29)).to eq 90
    expect(a(30)).to eq 45
  end

end
