require 'prime'

class PrimeFactors
  def self.hash(n)
    factors_hash = {}
    return {} if n == 0
    Prime.each do |q|
      break if n == 1
      factors_hash[q] = 0
      n /= q while n % q == 0 && factors_hash[q] += 1
    end
    factors_hash
  end
end
