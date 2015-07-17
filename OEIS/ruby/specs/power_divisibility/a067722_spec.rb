require_relative '../../scripts/power_divisibility/a067722'

describe OEIS do

  def a(n)
    OEIS.a067722(n)
  end

  it "should know first five values" do
    # expect(a(0)).to eq 1
    expect(a(1)).to eq 3
    expect(a(2)).to eq 6
    expect(a(3)).to eq 9
    expect(a(4)).to eq 5
  end

end
