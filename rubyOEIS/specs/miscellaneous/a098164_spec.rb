require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a098164(n)
  end

  it "should handle small values" do
    expect(a(0)).to eq 0
    expect(a(10)).to eq 9
    expect(a(11)).to eq 20
    expect(a(12)).to eq 11
    expect(a(13)).to eq 22
    expect(a(51)).to eq 201
    expect(a(53)).to eq 23
    expect(a(54)).to eq 12
  end

end
