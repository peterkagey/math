require_relative '../../scripts/power_divisibility/a254767'

describe OEIS do

  def a(n)
    OEIS.a254767(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 8
    expect(a(2)).to eq 4
    expect(a(3)).to eq 9
    expect(a(4)).to eq 16
    expect(a(5)).to eq 25
  end

end
