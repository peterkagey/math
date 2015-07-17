require_relative '../../scripts/non-palindromes/a252700'

describe OEIS do

  def a(n)
    OEIS.a252700(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 7
    expect(a(2)).to eq 42
    expect(a(3)).to eq 252
    expect(a(4)).to eq 1722
  end

end
