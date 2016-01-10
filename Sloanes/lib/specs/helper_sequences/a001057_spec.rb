require_relative '../../scripts/helper_sequences/a001057'

describe OEIS do

  def a(n)
    OEIS.a001057(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq -1
    expect(a(3)).to eq 2
    expect(a(4)).to eq -2
  end

end
