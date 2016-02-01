class Integer

  def xor(other, opts = {})
    base = opts[:base] || 3
    a, b = self, other

    ary = []
    until [a, b] == [0, 0] do
      ary << (a + b) % base

      a, b = a/base, b/base
    end

    ary.reverse.map(&:to_s).join.to_i(base)
  end

end
