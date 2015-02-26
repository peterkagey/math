require 'prime'
require_relative '../scripts/A067565'

describe OEIS do

  def a(n)
    OEIS.A067565(n)
  end

  it "should know the small cases" do
    expect(a(6)).to eq 2
    expect(a(8)).to eq 3
    expect(a(10)).to eq 5
    expect(a(12)).to eq 6
  end

  it "should handle perfect squares" do
    (1..70).each { |k| expect(a(k*k)).to eq k*k }
  end

  it "should know: a(k) == 0 iff k is prime" do
    (1..5040).each do |k|
      expect([k, a(k)]).to eq     [k, 0] if  Prime.prime?(k)
      expect([k, a(k)]).not_to eq [k, 0] if !Prime.prime?(k)
    end
  end

  it "should not try to go beyond 5040" do
    expect(a(5041)).to eq nil
  end

end