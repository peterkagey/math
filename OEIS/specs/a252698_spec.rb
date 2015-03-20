require_relative '../scripts/a252698'

describe OEIS do

  def a(n)
    OEIS.a252698(n)
  end

  it "should know first five values" do
    expect(a(0)).to eq 0
    expect(a(1)).to eq 5
    expect(a(2)).to eq 20
    expect(a(3)).to eq 80
    expect(a(4)).to eq 380
  end

end
