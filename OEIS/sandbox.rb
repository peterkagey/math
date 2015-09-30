require "/Users/pkagey/personal/math/OEIS/ruby/scripts/helpers/subset_logic.rb"

module Sandbox

  class A067597

    def initialize
      p binary_palindromes
      a = []
      binary_palindromes.each_subset do |subset|
        break if subset.length > 1 && subset[-1] + subset[-2] > 0b111111
        a << subset.reduce(:+)
      end
      p a
      p (0..64).to_a.map { |i| a.count(i) }
    end

    def binary_palindromes
      ary = []
      (1...2**4).each do |i|
        b = i.to_s(2)
        ary << (b + b.reverse)
        ary << (b + b.reverse[1..-1])
      end
      ary.map { |i| i.to_i(2) }.sort
    end

  end

end

# Sandbox::A067597.new
