require_relative '../../scripts/palindromes/a082461'

describe OEIS do

  def a(n)
    OEIS.a082461(n)
  end

  it "should know first 30 values" do
    expect(a(1)).to eq 1010
    expect(a(2)).to eq 1011
    expect(a(3)).to eq 1021
    expect(a(4)).to eq 1031
    expect(a(5)).to eq 1041
    expect(a(6)).to eq 1051
    expect(a(7)).to eq 1061
    expect(a(8)).to eq 1071
    expect(a(9)).to eq 1081
    expect(a(10)).to eq 1091
    expect(a(11)).to eq 1101
    expect(a(12)).to eq 1121
    expect(a(13)).to eq 1131
    expect(a(14)).to eq 1141
    expect(a(15)).to eq 1151
    expect(a(16)).to eq 1161
    expect(a(17)).to eq 1171
    expect(a(18)).to eq 1181
    expect(a(19)).to eq 1191
    expect(a(20)).to eq 1201
    expect(a(21)).to eq 1211
    expect(a(22)).to eq 1212
    expect(a(23)).to eq 1231
    expect(a(24)).to eq 1241
    expect(a(25)).to eq 1251
    expect(a(26)).to eq 1261
    expect(a(27)).to eq 1271
    expect(a(28)).to eq 1281
    expect(a(29)).to eq 1291
    expect(a(30)).to eq 1301
  end

end
