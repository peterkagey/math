def prime_factors(n, primes)
  prime_factors_hash = Hash.new(0)
  primes.each do |k|
    break if n < k
    while n % k == 0
      n /= k
      prime_factors_hash[k] += 1
    end
  end
  prime_factors_hash
end
