require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272036(n)
  end

  it "should know first three values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 38
    expect(a(3)).to eq 2090
  end

end
