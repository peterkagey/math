require_relative '../scripts/a094536'

describe OEIS do

  def a(n)
    OEIS.a094536(n)
  end

  it "should handle small values" do
    # pending("")
    expect(a(0)).to eq 0
    expect(a(1)).to eq 0
    expect(a(2)).to eq 2
    expect(a(3)).to eq 4
    expect(a(4)).to eq 10
  end

  it "should know that a(2*k+1) = 2 * a(2*k)" do
    (5..10).each do |k|
      expect([k, a(2*k+1)]).to eq [k, 2*a(2*k)]
    end
  end

end