require_relative '../scripts/a252703'

describe OEIS do

  def a(n)
    OEIS.a252703(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 10
    expect(a(2)).to eq 90
    expect(a(3)).to eq 810
    expect(a(4)).to eq 8010
  end

end
