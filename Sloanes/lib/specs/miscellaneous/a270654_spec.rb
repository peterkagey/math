require_relative '../../scripts/miscellaneous/a270654'

describe OEIS do

  def a(n)
    OEIS.a270654(n)
  end

  it "should know first 25 values" do
    expect(a(1)).to eq 0
    expect(a(2)).to eq 1
    expect(a(3)).to eq 1
    expect(a(4)).to eq 5
    expect(a(5)).to eq 1
    expect(a(6)).to eq 14
    expect(a(7)).to eq 1
    expect(a(8)).to eq 4
    expect(a(9)).to eq 14
    expect(a(10)).to eq 17
    expect(a(11)).to eq 1
    expect(a(12)).to eq 42
    expect(a(13)).to eq 9
    expect(a(14)).to eq 27
    expect(a(15)).to eq 23
    expect(a(16)).to eq 42
    expect(a(17)).to eq 44
    expect(a(18)).to eq 47
    expect(a(19)).to eq 37
    expect(a(20)).to eq 70
    expect(a(21)).to eq 0
    expect(a(22)).to eq 60
    expect(a(23)).to eq 76
    expect(a(24)).to eq 66
    expect(a(25)).to eq 59
  end

end
