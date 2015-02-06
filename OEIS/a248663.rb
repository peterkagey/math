require 'prime'
def f(n)
  a = 0
  reverse_primes = Prime.each(n).to_a.reverse
  reverse_primes.each do |prime|
    a <<= 1
    while n % prime == 0
      n /= prime
      a ^= 1
    end
  end
  a
end
