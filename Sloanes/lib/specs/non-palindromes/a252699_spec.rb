require_relative '../../scripts/non-palindromes/a252699'

describe OEIS do

  def a(n)
    OEIS.a252699(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 6
    expect(a(2)).to eq 30
    expect(a(3)).to eq 150
    expect(a(4)).to eq 870
  end

end
