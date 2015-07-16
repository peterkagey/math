require_relative '../scripts/a249641'

describe OEIS do

  def a(n)
    OEIS.a249641(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 8
    expect(a(3)).to eq 120
    expect(a(4)).to eq 1016
  end

end
