require 'prime'
def sieve_of_eratosthenes(n)
  Prime.each(n).to_a
end
