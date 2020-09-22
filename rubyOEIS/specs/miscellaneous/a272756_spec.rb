require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272756(n)
  end

  it "should correctly compute transitional values" do
    expect(a(1)).to eq 3
    expect(a(2)).to eq 5

    expect(a(3)).to eq 5
    expect(a(4)).to eq 6

    expect(a(5)).to eq 6
    expect(a(6)).to eq 7

    expect(a(9)).to eq 7
    expect(a(10)).to eq 8

    expect(a(15)).to eq 8
    expect(a(16)).to eq 9

    expect(a(28)).to eq 9
    expect(a(29)).to eq 10

    expect(a(51)).to eq 10
    expect(a(52)).to eq 11

    expect(a(93)).to eq 11
    expect(a(94)).to eq 12
  end

end
