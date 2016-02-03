require_relative '../../scripts/remainder_game/a268059'

describe OEIS do

  def a(n)
    OEIS.a268059(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 1
    expect(a(4)).to eq 1
    expect(a(5)).to eq 1
  end

end