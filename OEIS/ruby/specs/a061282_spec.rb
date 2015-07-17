require_relative '../scripts/a061282'

describe OEIS do

  def a(n)
    OEIS.a061282(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 2
    expect(a(4)).to eq 3
    expect(a(5)).to eq 4
  end

  it "should know powers of three" do
    expect(a(3**0)).to eq 1
    expect(a(3**1)).to eq 2
    expect(a(3**2)).to eq 3
    expect(a(3**3)).to eq 4
    expect(a(3**4)).to eq 5
  end

end
