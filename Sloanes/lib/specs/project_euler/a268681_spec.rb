require_relative '../../scripts/project_euler/a268681'

describe OEIS do

  def a(n)
    OEIS.a268681(n)
  end

  it "should know first 10 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 1
    expect(a(3)).to eq 3
    expect(a(4)).to eq 6
    expect(a(5)).to eq 12
    expect(a(6)).to eq 27
    expect(a(7)).to eq 42
    expect(a(8)).to eq 105
    expect(a(9)).to eq 175
    expect(a(10)).to eq 175
  end

end
