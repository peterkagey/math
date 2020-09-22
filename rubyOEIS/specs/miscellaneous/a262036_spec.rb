require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a262036(n)
  end

  it "should know the first few record values" do
    expect(a(2)).to eq 1
    expect(a(3)).to eq 3
    expect(a(10)).to eq 662
  end

end
