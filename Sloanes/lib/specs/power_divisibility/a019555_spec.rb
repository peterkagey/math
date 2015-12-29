require_relative '../../scripts/power_divisibility/a019555'
# A019555: Smallest number whose cube is divisible by n.
describe OEIS do

  def a(n)
    OEIS.a019555(n)
  end

  it "should handle a(1)" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 2
    expect(a(3)).to eq 3
    expect(a(4)).to eq 2
  end

end
