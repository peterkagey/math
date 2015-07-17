require_relative '../../scripts/non-palindromes/a252702'

describe OEIS do

  def a(n)
    OEIS.a252702(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 9
    expect(a(2)).to eq 72
    expect(a(3)).to eq 576
    expect(a(4)).to eq 5112
  end

end
