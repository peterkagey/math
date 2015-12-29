class Integer

  def xor(other, opts = {})
    base = opts[:base] || 3
    a, b = self, other

    ary = []
    until [a, b] == [0, 0] do
      ary << (a % base + b % base) % base

      a /= base # Shift to the right one digit
      b /= base #
    end

    ary.reverse.map(&:to_s).join.to_i(base)
  end

end
