require_relative '../../scripts/miscellaneous/a261865'
require_relative '../../scripts/miscellaneous/a005117'

describe OEIS do

  def a(n)
    OEIS.a261865(n)
  end

  it "should know the first few record values" do
    expect(a(1)).to eq   2
    expect(a(3)).to eq   3
    expect(a(23)).to eq  7
    expect(a(30)).to eq  15
    expect(a(40)).to eq  5
    expect(a(54)).to eq  13
    expect(a(61)).to eq  6
    expect(a(99)).to eq  11
    expect(a(170)).to eq 10
    expect(a(184)).to eq 38
    expect(a(307)).to eq 21
    expect(a(662)).to eq 14
    expect(a(877)).to eq 22
    expect(a(880)).to eq 19
    expect(a(993)).to eq 17
  end

end
