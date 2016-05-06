require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a065413(n)
  end

  it "should know a few special values" do
    expect(a(1)).to eq 1
    expect(a(13)).to eq 0
    expect(a(23)).to eq 3
    expect(a(27)).to eq 2

    expect(a(180)).to eq 1
    expect(a(181)).to eq 3
    expect(a(182)).to eq 2
    expect(a(183)).to eq 0
  end

end
