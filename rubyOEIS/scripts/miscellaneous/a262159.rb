require 'prime'

class A262159Builder

  def self.sequence(target_length = 1000)
    a = [1]

    (1...target_length).each do
      k = a.last + 1
      k += 1 while Prime.prime?(k) || Prime.prime?(a.last + k)
      a << k
    end
    a
  end

end

class OEIS
  A262159_SEQUENCE = A262159Builder.sequence

  def self.a262159(n)
    raise "A262159 is not defined for n < 1 (n = #{n})." if n < 1
    A262159_SEQUENCE[n-1] || A262159Builder.sequence(n).last
  end

end
