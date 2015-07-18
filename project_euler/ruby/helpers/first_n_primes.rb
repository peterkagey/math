require_relative 'sieve_of_eratosthenes'
require_relative 'log'

def first_n_primes(n)
  k = 67 if n < 20                  # upper bound on primes
  k ||= (n * (log(n) + log(log(n)) - 0.5)).ceil # is valid for n >= 20
  Prime.each(k).to_a[0...n]
end
