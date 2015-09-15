require_relative 'helpers/sequence_path_iterator'
class BFileCoverage

  def self.missing_b_files
    BFilePathIterator.missing_b_files
  end

  EXPECTED = [
    "b000002", # a(n) is length of n-th run
    "b000073", # Tribonacci numbers
    "b005117", # Squarefree numbers
    "b007913", # Squarefree part of n
    "b070229", # Next m>n such that m is divisible by lpf(n)
    "b000188", # Square root of largest square dividing n.
  ]
end
