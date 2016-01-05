require_relative '../helpers/sequence_path_iterator'

describe "OEIS Tests" do

  EXPECTED = [
    "b000002", # a(n) is length of n-th run
    "b000073", # Tribonacci numbers
    "b000188", # Square root of largest square dividing n.
    "b004489", # Base-3 XOR table.
    "b005117", # Squarefree numbers
    "b006995", # Binary palindromes.
    "b007913", # Squarefree part of n
    "b070229", # Next m>n such that m is divisible by lpf(n)
    "b071068", # Number of partitions of n into two squarefree numbers.
  ]

  it "should check that all b-files are present." do
    unexpectedly_missing_b_files = BFilePathIterator.missing_b_files - EXPECTED
    expect(unexpectedly_missing_b_files).to eq []
  end

end
