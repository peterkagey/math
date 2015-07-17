require_relative '../../scripts/palindromes/a249639'

describe OEIS do

  def a(n)
    OEIS.a249639(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 6
    expect(a(3)).to eq 66
    expect(a(4)).to eq 426
  end

end
