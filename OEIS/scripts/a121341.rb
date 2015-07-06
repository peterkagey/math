class OEIS

  # Number of decimal places before 1/n either recurs or terminates.
  def self.a121341(n)
    ary, modulus = [0], 1
    until ary.include?(modulus)
      ary << modulus
      modulus = 10 * modulus % n
    end
    ary.length - 1
  end

end
