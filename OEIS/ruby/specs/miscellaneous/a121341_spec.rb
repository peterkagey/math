require_relative '../../scripts/miscellaneous/a121341'

describe OEIS do

  def a(n)
    OEIS.a121341(n)
  end

  it "should handle small values" do
    # pending("")
    expect(a(2)).to eq 1
    expect(a(3)).to eq 1
    expect(a(4)).to eq 2
    expect(a(5)).to eq 1
    expect(a(6)).to eq 2
    expect(a(7)).to eq 6
    expect(a(8)).to eq 3
    expect(a(9)).to eq 1
    expect(a(10)).to eq 1
    expect(a(72)).to eq 4
    expect(a(398)).to eq 100
    expect(a(998)).to eq 499
  end

end
