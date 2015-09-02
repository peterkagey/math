require_relative '../helpers/english_number.rb'

class OEIS

  A000052_RANGES = [0...10, 10...100, 100...1000, 1000...10000]
  A000052_SEQ    = A000052_RANGES.flat_map do |range|
    range.to_a.sort_by { |i| EnglishNumber.new(i).to_s }
  end

  def self.a000052(n)
    raise "Numbers this large are not supported: (#{n})" if n > 10000
    A000052_SEQ[n]
  end

end

p OEIS.a000052(0)
