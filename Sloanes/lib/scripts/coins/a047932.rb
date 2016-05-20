require_relative "../helpers/sums_and_differences"
class A047932Builder

  def self.sequence(target_length = 10)
    ary = [0,1,2,2,2,2,3]
    i = 0
    while ary.length <= target_length + 1
      1.times { ary += [2] + [3] * (i + 0) }
      4.times { ary += [2] + [3] * (i + 1) }
      1.times { ary += [2] + [3] * (i + 2) }
      i += 1
    end
    ary.cumulative_sum
  end

end

class OEIS

  A047932_SEQUENCE = A047932Builder.sequence

  def self.a047932(n)
    A047932_SEQUENCE[n - 1] || A047932Builder.sequence(n)[n - 1]
  end

end
