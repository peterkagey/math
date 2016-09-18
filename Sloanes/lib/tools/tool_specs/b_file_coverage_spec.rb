require_relative '../helpers/sequence_path_iterator'

describe "OEIS Tests" do

  EXPECTED = [
    # Alec Sequences
    "269347", # Alec's first sequence

    # EKG
    "064413", # EKG sequence
    "169849", # EKG Sequence starting at 9.
    "256417", # Smoothed EKG sequence

    # Helper sequences
    "000005", # Number of divisors of n.
    "000045", # Fibonacci sequence.
    "000120", # Number of 1s in binary representation of n.
    "000188", # Square root of largest square dividing n.
    "000196", # Integer part of square root of n.
    "000217", # Triangle numbers.
    "000330", # n*(n+1)*(2*n+1)/6
    "000523", # Bit length - 1
    "000788", # Partial sums of A000120
    "001057", # (-1)^(n+1) * floor((n + 1)/2)
    "002024", # n appears n times
    "002061", # n**2 - n + 1
    "002522", # n**2 + 1
    "003056", # n appears n+1 times
    "003059", # n appears 2*n - 1 times.
    "003415", # arithmetic derivative of n
    "007955", # Product of divisors of n
    "005117", # Squarefree numbers
    "007913", # Squarefree part of n
    "032741", # Number of divisors of n
    "047838", # floor(n^2/2) - 1.
    "053645", # Distance to largest power of 2 less than or equal to n.
    "054519", # 1 + sum of A000005
    "057944", # Largest triangular number less than or equal to n
    "060432", # Partial sums of A002024.
    "070229", # Next m>n such that m is divisible by lpf(n)
    "070939", # Length of binary representation of n.
    "071068", # Number of partitions of n into two squarefree numbers.

    # Miscellaneous
    "000002", # a(n) is length of n-th run

    # Palindromes
    "006995", # Binary palindromes.

    # Power Divisibilty
    "019554", # Smallest number whose square is divisible by n.

    # Project Euler
    "080715", # Sums of divisors are prime
    "085731", # gcd(n, a003415(n))

    # Tables
    "004489", # Base-3 XOR table.
  ]

  it "should check that all b-files are present." do
    unexpectedly_missing_b_files = BFilePathIterator.new.missing_b_files - EXPECTED
    unexpectedly_missing_b_files.select! { |f| !(f =~ /^9999..$/)}
    expect(unexpectedly_missing_b_files).to eq []
  end

end
