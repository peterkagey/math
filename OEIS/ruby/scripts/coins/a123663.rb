class OEIS

  # Number of shared edges in a spiral of n unit squares.
  def self.a123663(n)
    a123663 = [0]
    k = 0
    a_i = 0
    loop do
      2.times do
        k.times do
          a_i += 2
          a123663 << a_i
        end
        a_i += 1
        a123663 << a_i
      end
      k += 1
      return a123663[n-1] if a123663.length >= n
    end
  end
end
