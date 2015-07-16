require_relative '../scripts/a248122'

describe OEIS do

  def a(n)
    OEIS.a248122(n)
  end

  it "should handle small values" do
    # 0, 0, 3, 15, 51
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 3
    expect(a(3)).to eq 15
    expect(a(4)).to eq 51
  end

end