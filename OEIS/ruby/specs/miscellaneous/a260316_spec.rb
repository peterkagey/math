require_relative '../../scripts/miscellaneous/a260316'

describe OEIS do

  def a(n)
    OEIS.a260316(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 1
    expect(a(3)).to eq 1
    expect(a(4)).to eq 3
  end

end
