require_relative '../../scripts/miscellaneous/a263135'

describe OEIS do

  def a(n)
    OEIS.a263135(n)
  end

  it "should correctly compute small values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 1
    expect(a(3)).to eq 2
    expect(a(4)).to eq 3
    expect(a(5)).to eq 4
    expect(a(6)).to eq 6
    expect(a(7)).to eq 7
    expect(a(8)).to eq 8
    expect(a(9)).to eq 9
    expect(a(10)).to eq 11
    expect(a(11)).to eq 12
    expect(a(12)).to eq 13
  end

  it "should know the relationship with hexagonal numbers" do
    (1..10).each do |i|
      vertices = 6 * i**2
      edges = 9 * i**2 - 3 * i
      expect(a(vertices)).to eq edges
    end
  end

end
