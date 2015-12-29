require_relative '../../scripts/miscellaneous/a227192'

describe OEIS do

  def a(n)
    OEIS.a227192(n)
  end

  it "should know first ten values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 3
    expect(a(3)).to eq 2
    expect(a(4)).to eq 5
    expect(a(5)).to eq 6
    expect(a(6)).to eq 4
    expect(a(7)).to eq 3
    expect(a(8)).to eq 7
    expect(a(9)).to eq 8
    expect(a(10)).to eq 10
  end

end
