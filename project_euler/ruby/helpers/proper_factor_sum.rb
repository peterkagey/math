def proper_factor_sum(n, primes)
  factors = [1]
  prime_factors(n, primes).each do |k,v|
    factors = (0..v).collect{ |i| factors.collect{|x| x * k ** i} }.flatten
  end
  proper_factors = factors - [n]
  proper_factors.reduce(:+)
end
