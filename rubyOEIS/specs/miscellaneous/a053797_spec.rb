require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a053797(n)
  end

  it "should know some values" do
    expect(a(0)).to eq 1
    expect(a(1)).to eq 2
    expect(a(10)).to eq 1
    expect(a(11)).to eq 2
    expect(a(12)).to eq 3
    expect(a(19)).to eq 1
    expect(a(20)).to eq 2
    expect(a(33)).to eq 3
    expect(a(34)).to eq 1
    expect(a(36)).to eq 2
    expect(a(67)).to eq 4
    expect(a(68)).to eq 1
    expect(a(72)).to eq 2
    expect(a(97)).to eq 3
    expect(a(98)).to eq 1
    expect(a(99)).to eq 3
  end

end
