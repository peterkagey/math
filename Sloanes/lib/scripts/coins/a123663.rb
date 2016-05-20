class OEIS

  # Number of shared edges in a spiral of n unit squares.
  def self.a123663(n)
    a123663 = [0]
    a_i = 0
    (0..Float::INFINITY).each do |k|
      break if a123663.length >= n
      2.times do
        k.times { a123663 << a_i += 2 }
        a123663 << a_i += 1
      end
    end
    a123663[n - 1]
  end
end
