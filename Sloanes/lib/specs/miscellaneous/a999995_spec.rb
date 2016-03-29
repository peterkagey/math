require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a999995(n)
  end

  it "should know a(1) = 1 is a special case" do
    expect(a(1)).to eq 1
  end

  it "should know A999995(A054519(k))" do
    expect(a(2)).to eq [1, 1].reduce(:*)
    expect(a(4)).to eq [1, 1, 2, 1].reduce(:*)
    expect(a(6)).to eq [1, 1, 2, 1, 3, 1].reduce(:*)
    expect(a(9)).to eq [1, 1, 2, 2, 1, 3, 1, 4, 1].reduce(:*)
    expect(a(11)).to eq [1, 1, 2, 2, 1, 3, 1, 4, 1, 5, 1].reduce(:*)
    expect(a(15)).to eq [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1].reduce(:*)
    expect(a(17)).to eq [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1].reduce(:*)
    expect(a(21)).to eq [1, 1, 2, 4, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1].reduce(:*)
    expect(a(24)).to eq [1, 1, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1].reduce(:*)
    expect(a(28)).to eq [1, 1, 2, 5, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1, 10, 1]  .reduce(:*)
  end

  it "should compute when k is a perfect square" do
    expect(a(7)).to eq [1, 1, 2, 2, 1, 3, 1].reduce(:*)
    expect(a(8)).to eq [1, 1, 2, 1, 3, 1, 4, 1].reduce(:*)
    expect(a(22)).to eq [1, 1, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1].reduce(:*)
    expect(a(23)).to eq [1, 1, 2, 4, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1].reduce(:*)
  end

  it "should compute when k is not a perfect square" do
    expect(a(13)).to eq [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1].reduce(:*)
    expect(a(19)).to eq [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1].reduce(:*)
    expect(a(26)).to eq [1, 1, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1, 10, 1].reduce(:*)
  end

  it "should compute conjectured values part 1" do
    expect(a(3)).to eq [1, 2, 1].reduce(:*)
    expect(a(10)).to eq [1, 1, 2, 1, 3, 1, 4, 1, 5, 1].reduce(:*)
    expect(a(12)).to eq [1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1].reduce(:*)
    expect(a(14)).to eq [1, 1, 2, 1, 3, 2, 3, 1, 4, 1, 5, 1, 6, 1].reduce(:*)
  end

  it "should compute conjectured values part 2" do
    # a(5) forgoes (1, 3) and (3, 1) for (1, 1) and (2, 2)
    expect(a(5)).to be <= [1, 1, 2, 2, 1].reduce(:*)
    # a(16) forgoes (1, 7) and (7, 1) for (2, 2) and (3, 3)
    expect(a(16)).to be <= [1, 1, 2, 2, 3, 3, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1].reduce(:*)
    # a(18) forgoes (1, 8) and (8, 1) for (2, 2) and (3, 3)
    expect(a(18)).to be <= [1, 1, 2, 2, 3, 3, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1].reduce(:*)
    # a(20) forgoes (2, 4) and (4, 2) for (2, 2) and (3, 3)
    expect(a(20)).to be <= [1, 1, 2, 2, 3, 3, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1].reduce(:*)
  end

end
