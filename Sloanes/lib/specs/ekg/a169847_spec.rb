require_relative '../../scripts/ekg/a169847'

describe OEIS do

  def a(n)
    OEIS.a169847(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 8
    expect(a(2)).to eq 2
    expect(a(3)).to eq 4
    expect(a(4)).to eq 6
    expect(a(5)).to eq 3
  end

end
