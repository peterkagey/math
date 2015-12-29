require_relative '../helpers/is_square.rb'

class A053797Builder

  def self.sequence
    a053797 = []; counter = 0
    Integer::SQUAREFREE.each do |is_squarefree|
      (counter += 1; next) unless is_squarefree
      a053797 << counter unless counter == 0
      counter = 0
    end

    a053797
  end

end

class OEIS

  A053797_SEQUENCE = A053797Builder.sequence

  def self.a053797(n)
    A053797_SEQUENCE[n]
  end

end
