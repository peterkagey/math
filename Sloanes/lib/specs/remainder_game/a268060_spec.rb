require_relative '../../scripts/remainder_game/a268060'

describe OEIS do

  def a(n)
    OEIS.a268060(n)
  end

  it "should know first 15 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 1
    expect(a(3)).to eq 2
    expect(a(4)).to eq 3
    expect(a(5)).to eq 3
    expect(a(6)).to eq 4
    expect(a(7)).to eq 4
    expect(a(8)).to eq 5
    expect(a(9)).to eq 5
    expect(a(10)).to eq 6
    expect(a(11)).to eq 7
    expect(a(12)).to eq 7
    expect(a(13)).to eq 8
    expect(a(14)).to eq 9
    expect(a(15)).to eq 8
  end

end