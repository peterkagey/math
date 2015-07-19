require_relative '../../scripts/miscellaneous/a000073'

describe OEIS do

  def a(n)
    OEIS.a000073(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 1
    expect(a(3)).to eq 1
    expect(a(4)).to eq 2
  end

  it "should know the next five values" do
    expect(a(5)).to eq 4
    expect(a(6)).to eq 7
    expect(a(7)).to eq 13
    expect(a(8)).to eq 24
    expect(a(9)).to eq 44
  end

  it "should know the recursion" do
    n = 40
    expect(a(n)).to eq a(n-1) + a(n-2) + a(n-3)
  end

end
