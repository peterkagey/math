# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors of
# 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

# A number n is called deficient if the sum of its proper divisors is less
# than n and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit
# cannot be reduced any further by analysis even though it is known that the
# greatest number that cannot be expressed as the sum of two abundant numbers
# is less than this limit.

# Find the sum of all the positive integers which cannot be written as the sum
# of two abundant numbers.

start = Time.now

require_relative '../../helpers/sieve_of_eratosthenes'
require_relative '../../helpers/prime_factors'
require_relative '../../helpers/proper_factor_sum'

primes = sieve_of_eratosthenes(10000)


def abundant_numbers_calc(primes)
  # 2.3 seconds
  (2...28123).select { |i| i < proper_factor_sum(i, primes) }
end

abundant_numbers = abundant_numbers_calc(primes)


abundant_sum_bool = [false] * 28124
abundant_numbers.reverse.each do |a|
  abundant_numbers.each do |b|
    break if a + b > 28123
    abundant_sum_bool[a + b] = true
  end
end

asl = []
abundant_sum_bool.each_with_index{ |v, i| asl << i if v}
p ((1..28123).to_a - asl).reduce(:+)
p Time.now - start

# 4179871
# 4.900694 seconds
# Ugly solution
