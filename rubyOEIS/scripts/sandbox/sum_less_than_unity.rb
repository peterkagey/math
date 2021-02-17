# Count the number of subsets of {1, 2, ..., n} with reciprical sum strictly
# less than 1.

# A305442
require_relative '../helpers/subset_logic'
require_relative "../helpers/sums_and_differences"
def a(n)
  (1..n).to_a.count_subsets do |subset|
    subset.map { |i| 1.to_r/i }.reduce(0, :+) < 1
  end
end

p (0..15).map { |i| a(i) }.first_differences
