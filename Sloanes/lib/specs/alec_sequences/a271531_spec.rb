require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a271531(n)
  end

  it "should know first 25 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 1
    expect(a(3)).to eq 2
    expect(a(4)).to eq 1
    expect(a(5)).to eq 12
    expect(a(6)).to eq 1
    expect(a(7)).to eq 30
    expect(a(8)).to eq 3
    expect(a(9)).to eq 28
    expect(a(10)).to eq 9
    expect(a(11)).to eq 24
    expect(a(12)).to eq 5
    expect(a(13)).to eq 132
    expect(a(14)).to eq 3
    expect(a(15)).to eq 26
    expect(a(16)).to eq 7
    expect(a(17)).to eq 420
    expect(a(18)).to eq 1
    expect(a(19)).to eq 360
    expect(a(20)).to eq 3
    expect(a(21)).to eq 4
    expect(a(22)).to eq 5
    expect(a(23)).to eq 1680
    expect(a(24)).to eq 253
    expect(a(25)).to eq 84
  end

end
