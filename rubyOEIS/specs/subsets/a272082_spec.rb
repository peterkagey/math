require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272082(n)
  end

  it "should know a(10) through a(25)" do
    expect(a(10)).to eq 6
    expect(a(11)).to eq 4
    expect(a(12)).to eq 2
    expect(a(13)).to eq 12
    expect(a(14)).to eq 6
    expect(a(15)).to eq 4
    expect(a(16)).to eq 2
    expect(a(17)).to eq 1
    expect(a(18)).to eq 15
    expect(a(19)).to eq 10
    expect(a(20)).to eq 3
    expect(a(21)).to eq 2
    expect(a(22)).to eq 15
    expect(a(23)).to eq 10
    expect(a(24)).to eq 3
    expect(a(25)).to eq 2
  end

end
