require_relative '../../scripts/miscellaneous/a265389'

describe OEIS do

  def a(n)
    OEIS.a265389(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 6
    expect(a(2)).to eq 16
    expect(a(3)).to eq 27
    expect(a(4)).to eq 36
    expect(a(5)).to eq 46
  end

end
