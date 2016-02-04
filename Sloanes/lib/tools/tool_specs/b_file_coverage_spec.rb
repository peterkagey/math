require_relative '../helpers/sequence_path_iterator'

describe "OEIS Tests" do

  EXPECTED = [
    "b000002", # a(n) is length of n-th run
    "b000188", # Square root of largest square dividing n.
    "b000196", # Integer part of square root of n.
    "b000217", # Triangle numbers.
    "b000330", # n*(n+1)*(2*n+1)/6
    "b001057", # (-1)^(n+1) * floor((n+1) / 2)
    "b002024", # n appears n times
    "b002061", # n**2 - n + 1
    "b002522", # n**2 + 1
    "b003056", # n appears n+1 times
    "b003415", # arithmetic derivative of n
    "b004489", # Base-3 XOR table.
    "b047838", # floor(n^2/2) - 1.
    "b005117", # Squarefree numbers
    "b006995", # Binary palindromes.
    "b007913", # Squarefree part of n
    "b057944", # Largest triangular number less than or equal to n
    "b060432", # Partial sums of A002024.
    "b070229", # Next m>n such that m is divisible by lpf(n)
    "b071068", # Number of partitions of n into two squarefree numbers.
    "b080715", # Sums of divisors are prime
    "b085731", # gcd(n, a003415(n))
  ]

  it "should check that all b-files are present." do
    unexpectedly_missing_b_files = BFilePathIterator.missing_b_files - EXPECTED
    expect(unexpectedly_missing_b_files).to eq []
  end

end
