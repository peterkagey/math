require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a262343(n)
  end

  it "should know first six values" do
    expect(a(3)).to eq 1
    expect(a(4)).to eq 3
    expect(a(5)).to eq 9
    expect(a(6)).to eq 2
    expect(a(7)).to eq 15
    expect(a(8)).to eq 9
  end

end
