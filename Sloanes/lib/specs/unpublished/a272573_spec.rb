require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272573(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 3
    expect(a(4)).to eq 4
    expect(a(5)).to eq 5
    expect(a(6)).to eq 6
    expect(a(7)).to eq 7

    expect(a(8)).to eq 4
    expect(a(9)).to eq 6
    expect(a(10)).to eq 8
    expect(a(11)).to eq 5
    expect(a(12)).to eq 9
    expect(a(13)).to eq 8
    expect(a(14)).to eq 10
  end

end

describe Spokes do

  def neighbors(n)
    Spokes.new(n).neighbors
  end

  it "should know first five values" do
    expect(neighbors(1)).to eq []
    expect(neighbors(2)).to eq [1]
    expect(neighbors(3)).to eq [2, 1]
    expect(neighbors(4)).to eq [3, 1]
    expect(neighbors(5)).to eq [4, 1]
    expect(neighbors(6)).to eq [5, 1]
    expect(neighbors(7)).to eq [6, 2, 1]

    expect(neighbors(8)).to eq [7, 2]
    expect(neighbors(9)).to eq [8, 2]
  end

end
