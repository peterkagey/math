require_relative '../../scripts/miscellaneous/a269267'

describe OEIS do

  def a(n)
    OEIS.a269267(n)
  end

  it "should know first 5 values" do
    expect(a(1)).to eq 31
    expect(a(2)).to eq 33
    expect(a(3)).to eq 59
    expect(a(4)).to eq 62
    expect(a(5)).to eq 71
  end

end
