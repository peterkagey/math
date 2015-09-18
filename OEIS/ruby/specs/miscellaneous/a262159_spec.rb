require_relative '../../scripts/miscellaneous/a262159'

describe OEIS do

  def a(n)
    OEIS.a262159(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 8
    expect(a(3)).to eq 10
    expect(a(4)).to eq 12
    expect(a(5)).to eq 14
  end

end
