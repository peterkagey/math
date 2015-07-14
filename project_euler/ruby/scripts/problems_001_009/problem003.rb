# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

start = Time.now
require_relative '../function/sieve_of_eratosthenes'

def problem003(a)
  Prime.each(6900) do |prime|
    a /= prime while a % prime == 0
    return prime if a == 1
  end
end

p problem003(600851475143)
p Time.now-start
# 6857
# 0.003549 seconds
