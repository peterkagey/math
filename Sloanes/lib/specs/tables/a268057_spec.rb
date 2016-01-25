require_relative '../../scripts/tables/a268057'

describe OEIS do

  def a(n)
    OEIS.a268057(n)
  end

  it "should know first five values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 1
    expect(a(3)).to eq 1
    expect(a(4)).to eq 1
    expect(a(5)).to eq 2
  end

end
