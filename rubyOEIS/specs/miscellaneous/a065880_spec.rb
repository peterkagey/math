require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a065880(n)
  end

  it "should know first 25 values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 6
    expect(a(4)).to eq 4
    expect(a(5)).to eq 10
    expect(a(6)).to eq 12
    expect(a(7)).to eq 21
    expect(a(8)).to eq 8
    expect(a(9)).to eq 18
    expect(a(10)).to eq 20
    expect(a(11)).to eq 55
    expect(a(12)).to eq 24
    expect(a(13)).to eq 0
    expect(a(14)).to eq 42
    expect(a(15)).to eq 60
    expect(a(16)).to eq 16
    expect(a(17)).to eq 34
    expect(a(18)).to eq 36
    expect(a(19)).to eq 0
    expect(a(20)).to eq 40
    expect(a(21)).to eq 126
    expect(a(22)).to eq 110
    expect(a(23)).to eq 115
    expect(a(24)).to eq 48
  end

end
