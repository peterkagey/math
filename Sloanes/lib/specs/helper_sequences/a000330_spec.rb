require_relative '../../scripts/helper_sequences/a000330'

describe OEIS do

  def a(n)
    OEIS.a000330(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 1
    expect(a(2)).to eq 5
    expect(a(3)).to eq 14
    expect(a(4)).to eq 30
  end

end
