require_relative '../scripts/a252696'

describe OEIS do

  def a(n)
    OEIS.a252696(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 3
    expect(a(2)).to eq 6
    expect(a(3)).to eq 12
    expect(a(4)).to eq 30
  end

end
