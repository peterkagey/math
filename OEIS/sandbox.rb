class Sandbox

  def initialize(a_0, a_1, base = 3)
    @b = base
    a_1, a_0 = [a_0, a_1].sort
    @b_0 = a_0.to_s(base)
    @b_1 = a_1.to_s(base).rjust(@b_0.length, '0')
  end

  def xor
    ary_0 = @b_0.split("").map(&:to_i)
    ary_1 = @b_1.split("").map(&:to_i)
    result_ary = (0...ary_0.length)
    result_ary.map { |i| ary_0[i] + ary_1[i] % @b}.join.to_i(@b)
  end

end

class XOR
  def initialize(a_0, a_1, base = 3)
    @base = base
    @a_1, @a_0 = [a_0, a_1].sort
  end

  def b
    @base
  end

  def xor
    ary = []
    10.times do
      ary << (@a_0 % b + @a_1 % b) % b
      @a_0 /= b
      @a_1 /= b
    end

    ary.reverse.map(&:to_s).join.to_i(b)
  end

end
