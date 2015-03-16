require_relative '../scripts/a252697'

describe OEIS do

  def a(n)
    OEIS.a252697(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 4
    expect(a(2)).to eq 12
    expect(a(3)).to eq 36
    expect(a(4)).to eq 132
  end

end
