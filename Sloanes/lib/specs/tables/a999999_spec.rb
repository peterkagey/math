require_relative '../../scripts/tables/a999999'

describe OEIS do

  def a(n)
    OEIS.a999999(n)
  end

  it "should know first fifteen values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 1
    expect(a(3)).to eq 0
    expect(a(4)).to eq 0
    expect(a(5)).to eq 2
    expect(a(6)).to eq 0
    expect(a(7)).to eq 1
    expect(a(8)).to eq 2
    expect(a(9)).to eq 3
    expect(a(10)).to eq 0
    expect(a(11)).to eq 0
    expect(a(12)).to eq 0
    expect(a(13)).to eq 2
    expect(a(14)).to eq 4
  end

end
