require_relative '../../scripts/graham/a259527'

describe OEIS do

  def a(n)
    OEIS.a259527(n)
  end

  it "should compute non-square composites correctly." do
    expect(a(6)).to  eq 2
    expect(a(8)).to  eq 2
    expect(a(10)).to eq 2
    expect(a(12)).to eq 2
    expect(a(14)).to eq 2
    expect(a(15)).to eq 2
    expect(a(18)).to eq 2
    expect(a(20)).to eq 4
  end

  it "should compute small primes correctly." do
    expect(a(2)).to  eq 2
    expect(a(3)).to  eq 2
    expect(a(5)).to  eq 2
    expect(a(7)).to  eq 2
    expect(a(11)).to eq 8
    expect(a(13)).to eq 16
    expect(a(17)).to eq 64
    expect(a(19)).to eq 128
  end

  it "should know a(k^2)=1." do
    expect(a(1**2)).to eq 1
    expect(a(2**2)).to eq 1
    expect(a(3**2)).to eq 1
    expect(a(4**2)).to eq 1
    expect(a(5**2)).to eq 1
  end

  it "should be pretty quick!" do
    start = Time.now
    expect(a(19)).to eq 128
    expect(Time.now - start).to be < 0.1
  end

end
