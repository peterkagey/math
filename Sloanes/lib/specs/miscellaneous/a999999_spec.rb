require_relative '../../scripts/miscellaneous/a999999'

describe OEIS do

  def a(n)
    OEIS.a999999(n)
  end

  it "should know first 25 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 5
    expect(a(3)).to eq 10
    expect(a(4)).to eq 17
    expect(a(5)).to eq 28
    expect(a(6)).to eq 37
    expect(a(7)).to eq 50
    expect(a(8)).to eq 65
    expect(a(9)).to eq 82
    expect(a(10)).to eq 106
    expect(a(11)).to eq 122
    expect(a(12)).to eq 145
    expect(a(13)).to eq 170
    expect(a(14)).to eq 197
    expect(a(15)).to eq 228
    expect(a(16)).to eq 257
    expect(a(17)).to eq 294
    expect(a(18)).to eq 325
    expect(a(19)).to eq 362
    expect(a(20)).to eq 406
    expect(a(21)).to eq 442
    expect(a(22)).to eq 485
    expect(a(23)).to eq 530
    expect(a(24)).to eq 577
    expect(a(25)).to eq 628
  end

end
