load '/Users/pk/personal/math/Sloanes/lib/scripts/helpers/sums_and_differences.rb'

def a(n)
  (1..n)
    .to_a
    .permutation
    .map { |l| l.first_differences.map { |i| i % n } }
    .select { |l| l == l.reverse }
    .uniq
    .length
end

(1..15).each { |i| puts "#{i} #{a i}" }
