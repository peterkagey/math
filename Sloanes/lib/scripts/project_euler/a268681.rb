require_relative '../helpers/n_choose_k'
require 'prime'
require 'set'

class OEIS
  def self.a268681(rows = 51)
    primes = Prime.each(rows**0.5).to_a

    unique_values = SortedSet.new([1] + rows.times.flat_map do |n|
      (1..n/2).map { |k| n.choose(k) }
    end)

    unique_values.select { |i| primes.all? { |p| i % (p**2) != 0 } }.reduce(:+)
  end
end
