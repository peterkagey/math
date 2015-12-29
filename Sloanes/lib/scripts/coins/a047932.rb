class A047932Builder

  def self.sequence(target_length = 10000)
    ary = [0,1,2,2,2,2,3]
    i = 0
    while ary.length <= target_length + 1
      1.times { ary += [2] + [3] * (i + 0) }
      4.times { ary += [2] + [3] * (i + 1) }
      1.times { ary += [2] + [3] * (i + 2) }
      i += 1
    end
    a_i = 0
    ary.map { |a_n| a_i += a_n }
  end

end

class OEIS

  A047932_SEQUENCE = A047932Builder.sequence

  def self.a047932(n)
    A047932_SEQUENCE[n - 1] || A047932Builder.sequence(n)[n]
  end

end
