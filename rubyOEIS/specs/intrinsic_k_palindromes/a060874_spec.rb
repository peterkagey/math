require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a060874(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 9
    expect(a(2)).to eq 15
    expect(a(3)).to eq 28
    expect(a(4)).to eq 40
    expect(a(5)).to eq 52
  end

end
