require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272761(n)
  end

  it "should know 10 of the first 25 values" do
    expect(a(1)).to eq 23
    expect(a(2)).to eq 27
    expect(a(3)).to eq 37
    expect(a(4)).to eq 41
    expect(a(5)).to eq 46

    expect(a(20)).to eq 92
    expect(a(21)).to eq 101
    expect(a(22)).to eq 105
    expect(a(23)).to eq 106
    expect(a(24)).to eq 107
    expect(a(25)).to eq 108
  end

end
