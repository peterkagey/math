require_relative '../../scripts/miscellaneous/a262036'

describe OEIS do

  def a(n)
    OEIS.a262036(n)
  end

  it "should know the first few record values" do
    expect(a(2)).to eq 1
    expect(a(3)).to eq 3
    expect(a(10)).to eq 662
  end

end
