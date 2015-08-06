require_relative '../../scripts/graham/a260896'

describe OEIS do

  def a(n)
    OEIS.a260896(n)
  end

  it "should handle small values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 0
    expect(a(3)).to eq 1
    expect(a(4)).to eq 1
    expect(a(5)).to eq 1
    expect(a(6)).to eq 3
    expect(a(7)).to eq 3
    expect(a(8)).to eq 2
    expect(a(9)).to eq 3
  end

  it "should handle large values" do
    expect(a(4944)).to eq 22
  end

end
