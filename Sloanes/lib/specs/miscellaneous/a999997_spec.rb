require_relative '../../scripts/miscellaneous/a999997'

describe OEIS do

  def a(n)
    OEIS.a999997(n)
  end

  it "should know first 20 values" do
    expect(a(1)).to eq 5
    expect(a(2)).to eq 17
    expect(a(3)).to eq 28
    expect(a(4)).to eq 37
    expect(a(5)).to eq 82
    expect(a(6)).to eq 106
    expect(a(7)).to eq 122
    expect(a(8)).to eq 197
    expect(a(9)).to eq 228
    expect(a(10)).to eq 257
    expect(a(11)).to eq 294
    expect(a(12)).to eq 362
    expect(a(13)).to eq 406
    expect(a(14)).to eq 577
    expect(a(15)).to eq 628
    expect(a(16)).to eq 677
    expect(a(17)).to eq 842
    expect(a(18)).to eq 906
    expect(a(19)).to eq 1161
    expect(a(20)).to eq 1228
  end

end
