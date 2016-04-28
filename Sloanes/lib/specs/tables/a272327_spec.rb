require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

describe OEIS do

  def a(n)
    OEIS.a272327(n)
  end

  it "should know first 45 values" do
    expect(a(1)).to eq 2
    expect(a(2)).to eq 4
    expect(a(3)).to eq 2
    expect(a(4)).to eq 6
    expect(a(5)).to eq 4
    expect(a(6)).to eq 2
    expect(a(7)).to eq 8
    expect(a(8)).to eq 6
    expect(a(9)).to eq 4
    expect(a(10)).to eq 2
    expect(a(11)).to eq 10
    expect(a(12)).to eq 6
    expect(a(13)).to eq 6
    expect(a(14)).to eq 4
    expect(a(15)).to eq 2
    expect(a(16)).to eq 12
    expect(a(17)).to eq 10
    expect(a(18)).to eq 6
    expect(a(19)).to eq 6
    expect(a(20)).to eq 4
    expect(a(21)).to eq 2
    expect(a(22)).to eq 14
    expect(a(23)).to eq 12
    expect(a(24)).to eq 10
    expect(a(25)).to eq 6
    expect(a(26)).to eq 6
    expect(a(27)).to eq 4
    expect(a(28)).to eq 2
    expect(a(29)).to eq 16
    expect(a(30)).to eq 14
    expect(a(31)).to eq 12
    expect(a(32)).to eq 10
    expect(a(33)).to eq 6
    expect(a(34)).to eq 6
    expect(a(35)).to eq 4
    expect(a(36)).to eq 2
    expect(a(37)).to eq 18
    expect(a(38)).to eq 12
    expect(a(39)).to eq 14
    expect(a(40)).to eq 12
    expect(a(41)).to eq 10
    expect(a(42)).to eq 6
    expect(a(43)).to eq 6
    expect(a(44)).to eq 4
    expect(a(45)).to eq 2
  end

end
