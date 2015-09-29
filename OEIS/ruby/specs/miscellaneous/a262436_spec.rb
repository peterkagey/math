require_relative '../../scripts/miscellaneous/a262436'

describe OEIS do

  def a(n)
    OEIS.a262436(n)
  end

  it "should be consistent with A212292." do
    expect(a((1 + 1)/2)).to eq 0
    expect(a((3 + 1)/2)).to eq 0
    expect(a((5 + 1)/2)).to eq 0
    expect(a((7 + 1)/2)).to eq 0
    expect(a((9 + 1)/2)).to eq 0
    expect(a((17 + 1)/2)).to eq 0
    expect(a((33 + 1)/2)).to eq 0
    expect(a((43 + 1)/2)).to eq 0
    expect(a((83 + 1)/2)).to eq 0
    expect(a((179 + 1)/2)).to eq 0
    expect(a((623 + 1)/2)).to eq 0
    expect(a((713 + 1)/2)).to eq 0
    expect(a((1019 + 1)/2)).to eq 0
  end

  it "should know some small terms that don't map to zero." do
    expect(a(6)).to eq 1
    expect(a(7)).to eq 1
    expect(a(8)).to eq 2
    expect(a(10)).to eq 1
    expect(a(11)).to eq 2
    expect(a(12)).to eq 1
    expect(a(13)).to eq 2
    expect(a(14)).to eq 1
    expect(a(15)).to eq 1
    expect(a(16)).to eq 3
  end

end
