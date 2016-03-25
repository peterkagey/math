require_relative '../../scripts/miscellaneous/a269347'

describe OEIS do

  def a(n)
    OEIS.a269347(n)
  end

  it "should know first 30 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 1
    expect(a(3)).to eq 3
    expect(a(4)).to eq 3
    expect(a(5)).to eq 3
    expect(a(6)).to eq 15
    expect(a(7)).to eq 3
    expect(a(8)).to eq 3
    expect(a(9)).to eq 30
    expect(a(10)).to eq 3
    expect(a(11)).to eq 3
    expect(a(12)).to eq 51
    expect(a(13)).to eq 3
    expect(a(14)).to eq 3
    expect(a(15)).to eq 84
    expect(a(16)).to eq 3
    expect(a(17)).to eq 3
    expect(a(18)).to eq 111
    expect(a(19)).to eq 3
    expect(a(20)).to eq 3
    expect(a(21)).to eq 150
    expect(a(22)).to eq 3
    expect(a(23)).to eq 3
    expect(a(24)).to eq 195
    expect(a(25)).to eq 3
    expect(a(26)).to eq 3
    expect(a(27)).to eq 246
    expect(a(28)).to eq 3
    expect(a(29)).to eq 3
    expect(a(30)).to eq 318
  end

end
