require 'prime'

class A053797Builder

  UPPER_BOUND = 35070 # Number of terms required to create the first 10000 terms of the sequence.

  def self.compute_non_squarefree_numbers
    bool_ary = Array.new(UPPER_BOUND)
    Prime.each(Math.sqrt(UPPER_BOUND)) do |p|
      (1.. UPPER_BOUND/p**2).each { |k| bool_ary[k * p **2] = true }
    end
    @non_squarefree_numbers = bool_ary.each_index.select { |i| bool_ary[i] }
  end

  def self.sequence
    compute_non_squarefree_numbers
    seq = []
    seq << first_run(@non_squarefree_numbers) while @non_squarefree_numbers != []
    seq
  end

  def self.first_run(ary)
    run_ary = [ary.shift]
    run_ary << ary.shift while ary[0] == run_ary.last + 1
    run_ary.length
  end

end

class OEIS

  A053797_SEQUENCE = A053797Builder.sequence

  def self.a053797(n)
    A053797_SEQUENCE[n]
  end

end
