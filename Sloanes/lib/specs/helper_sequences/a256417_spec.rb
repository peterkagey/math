require_relative '../../scripts/helper_sequences/a256417'

describe OEIS do

  def a(n)
    OEIS.a256417(n)
  end

  it "should know first 100 values" do
    expect(a(1)).to eq 1
    expect(a(2)).to eq 4
    expect(a(3)).to eq 4
    expect(a(4)).to eq 4
    expect(a(5)).to eq 6
    expect(a(6)).to eq 6
    expect(a(7)).to eq 12
    expect(a(8)).to eq 8
    expect(a(9)).to eq 10
    expect(a(10)).to eq 10
    expect(a(11)).to eq 10
    expect(a(12)).to eq 18
    expect(a(13)).to eq 14
    expect(a(14)).to eq 14
    expect(a(15)).to eq 14
    expect(a(16)).to eq 24
    expect(a(17)).to eq 16
    expect(a(18)).to eq 20
    expect(a(19)).to eq 22
    expect(a(20)).to eq 22
    expect(a(21)).to eq 22
    expect(a(22)).to eq 27
    expect(a(23)).to eq 30
    expect(a(24)).to eq 25
    expect(a(25)).to eq 35
    expect(a(26)).to eq 28
    expect(a(27)).to eq 26
    expect(a(28)).to eq 26
    expect(a(29)).to eq 26
    expect(a(30)).to eq 36
    expect(a(31)).to eq 32
    expect(a(32)).to eq 34
    expect(a(33)).to eq 34
    expect(a(34)).to eq 34
    expect(a(35)).to eq 42
    expect(a(36)).to eq 38
    expect(a(37)).to eq 38
    expect(a(38)).to eq 38
    expect(a(39)).to eq 45
    expect(a(40)).to eq 40
    expect(a(41)).to eq 44
    expect(a(42)).to eq 46
    expect(a(43)).to eq 46
    expect(a(44)).to eq 46
    expect(a(45)).to eq 48
    expect(a(46)).to eq 50
    expect(a(47)).to eq 52
    expect(a(48)).to eq 54
    expect(a(49)).to eq 56
    expect(a(50)).to eq 49
    expect(a(51)).to eq 63
    expect(a(52)).to eq 60
    expect(a(53)).to eq 55
    expect(a(54)).to eq 65
    expect(a(55)).to eq 70
    expect(a(56)).to eq 58
    expect(a(57)).to eq 58
    expect(a(58)).to eq 58
    expect(a(59)).to eq 66
    expect(a(60)).to eq 62
    expect(a(61)).to eq 62
    expect(a(62)).to eq 62
    expect(a(63)).to eq 72
    expect(a(64)).to eq 64
    expect(a(65)).to eq 68
    expect(a(66)).to eq 74
    expect(a(67)).to eq 74
    expect(a(68)).to eq 74
    expect(a(69)).to eq 75
    expect(a(70)).to eq 78
    expect(a(71)).to eq 76
    expect(a(72)).to eq 80
    expect(a(73)).to eq 82
    expect(a(74)).to eq 82
    expect(a(75)).to eq 82
    expect(a(76)).to eq 81
    expect(a(77)).to eq 84
    expect(a(78)).to eq 77
    expect(a(79)).to eq 88
    expect(a(80)).to eq 86
    expect(a(81)).to eq 86
    expect(a(82)).to eq 86
    expect(a(83)).to eq 90
    expect(a(84)).to eq 85
    expect(a(85)).to eq 95
    expect(a(86)).to eq 100
    expect(a(87)).to eq 92
    expect(a(88)).to eq 94
    expect(a(89)).to eq 94
    expect(a(90)).to eq 94
    expect(a(91)).to eq 96
    expect(a(92)).to eq 98
    expect(a(93)).to eq 91
    expect(a(94)).to eq 104
    expect(a(95)).to eq 102
    expect(a(96)).to eq 99
    expect(a(97)).to eq 105
    expect(a(98)).to eq 108
    expect(a(99)).to eq 106
    expect(a(100)).to eq 106
  end

end
