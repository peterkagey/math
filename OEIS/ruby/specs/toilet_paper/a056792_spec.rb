require_relative '../../scripts/toilet_paper/a056792'

describe OEIS do

  def a(n)
    OEIS.a056792(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 3
    expect(a(4)).to eq 3
    expect(a(5)).to eq 4
  end

  it "should know powers of three" do
    expect(a(2**0)).to eq 1
    expect(a(2**1)).to eq 2
    expect(a(2**2)).to eq 3
    expect(a(2**3)).to eq 4
    expect(a(2**4)).to eq 5
  end

end
