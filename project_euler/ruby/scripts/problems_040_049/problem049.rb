# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
# increases by 3330, is unusual in two ways: (i) each of the three terms are
# prime, and, (ii) each of the 4-digit numbers are permutations of one another.

# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
# exhibiting this property, but there is one other 4-digit increasing sequence.

# What 12-digit number do you form by concatenating the three terms in this
# sequence?

start = Time.now

require_relative '../function/sieve_of_eratosthenes'

def geometric_subsequence?(ary)
  max = ary.sort!.last # assumes ary of integers
  (0...ary.length-2).each do |a|
    (a+1...ary.length-1).each do |b|
      test_val = ary[b] + (ary[b] - ary[a])
      return [ary[a], ary[b], test_val] if ary.include?(test_val)
    end
  end
  return false
end

primes = sieve_of_eratosthenes(9999).select!{|x| x > 1000}
primes = primes.group_by{ |p| p.to_s.split("").sort.join }
primes.each do |k,v|
  next unless v.length >=3
  seq = geometric_subsequence?(v)
  p seq.join("").to_i if seq && !seq.include?(1487)
end

p Time.now - start

# 296962999629
# 0.011418 seconds
