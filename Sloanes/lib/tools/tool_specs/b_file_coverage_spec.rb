require_relative '../helpers/sequence_path_iterator'

describe "OEIS Tests" do

  EXPECTED = [
    # Alec Sequences
    "b269347", # Alec's first sequence

    # EKG
    "b064413", # EKG sequence
    "b169849", # EKG Sequence starting at 9.
    "b256417", # Smoothed EKG sequence

    # Helper sequences
    "b000005", # Number of divisors of n.
    "b000045", # Fibonacci sequence.
    "b000120", # Number of 1s in binary representation of n.
    "b000188", # Square root of largest square dividing n.
    "b000196", # Integer part of square root of n.
    "b000217", # Triangle numbers.
    "b000330", # n*(n+1)*(2*n+1)/6
    "b000523", # Bit length - 1
    "b000788", # Partial sums of A000120
    "b001057", # (-1)^(n+1) * floor((n + 1)/2)
    "b002024", # n appears n times
    "b002061", # n**2 - n + 1
    "b002522", # n**2 + 1
    "b003056", # n appears n+1 times
    "b003415", # arithmetic derivative of n
    "b007955", # Product of divisors of n
    "b005117", # Squarefree numbers
    "b007913", # Squarefree part of n
    "b032741", # Number of divisors of n
    "b047838", # floor(n^2/2) - 1.
    "b053645", # Distance to largest power of 2 less than or equal to n.
    "b054519", # 1 + sum of A000005
    "b057944", # Largest triangular number less than or equal to n
    "b060432", # Partial sums of A002024.
    "b070229", # Next m>n such that m is divisible by lpf(n)
    "b070939", # Length of binary representation of n.
    "b071068", # Number of partitions of n into two squarefree numbers.

    # Miscellaneous
    "b000002", # a(n) is length of n-th run

    # Palindromes
    "b006995", # Binary palindromes.

    # Project Euler
    "b080715", # Sums of divisors are prime
    "b085731", # gcd(n, a003415(n))

    # Tables
    "b004489", # Base-3 XOR table.
  ]

  it "should check that all b-files are present." do
    unexpectedly_missing_b_files = BFilePathIterator.new.missing_b_files - EXPECTED
    unexpectedly_missing_b_files.select! { |f| !(f =~ /^b9999..$/)}
    expect(unexpectedly_missing_b_files).to eq []
  end

end
