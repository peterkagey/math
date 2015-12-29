require_relative '../../scripts/coins/a047932'

describe OEIS do

  def a(n)
    OEIS.a047932(n)
  end

  it "should know a few values" do
    expect(a(1)).to eq 0
    expect(a(6)).to eq 9
    expect(a(11)).to eq 21
    expect(a(16)).to eq 34
    expect(a(21)).to eq 47
    expect(a(26)).to eq 60
    expect(a(31)).to eq 73
    expect(a(36)).to eq 87
    expect(a(41)).to eq 100
  end

end
