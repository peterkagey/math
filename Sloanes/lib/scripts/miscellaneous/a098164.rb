class EvenOdd
  def initialize(n)
    @n = n.to_s
  end

  def runlengths
    @runlengths ||= @n.scan(/([02468]+|[13579]+)/).flatten.map(&:length)
  end

  def bad?
    return true if runlengths.max > 2
    return true if runlengths.length > 2 && runlengths[1...-1].min < 2
    false
  end

  def pattern
    return if bad?
    raise "Cannot evaluate pattern on terms less than 10: (#{@n}" if @n.to_i < 10
    if %w(0 2 4 6 8).include? @n[0]
      runlengths[0] == 2 ? :eeoo : :eooe
    else
      runlengths[0] == 2 ? :ooee : :oeeo
    end
  end

  def next_pattern
    raise "Cannot evaluate next pattern on terms less than 10: (#{n}" if @n.to_i < 10
    if %w(0 2 4 6 8).include? @n.to_s[-1]
      runlengths[-1] == 2 ? :ooee : :eooe
    else
      runlengths[-1] == 2 ? :eeoo : :oeeo
    end
  end

  def next_term(pattern)
    n = @n.to_i
    n += 1 until EvenOdd.new(n + 1).pattern == pattern
    n + 1
  end

end

class A098164Builder

  def self.sequence(target_length = 100)
    last = {
      :eooe => 21,
      :eeoo => 20,
      :ooee => 9,
      :oeeo => 9
    }

    a098164 = [0, 2, 1, 3, 4, 6, 5, 7, 8, 21, 9, 20]

    until a098164.length > target_length do
      pattern       = EvenOdd.new(a098164.last).next_pattern
      last[pattern] = EvenOdd.new(last[pattern]).next_term(pattern)
      a098164 << last[pattern]
    end

    a098164
  end

end

class OEIS

  A098164_SEQUENCE = A098164Builder.sequence

  def self.a098164(n)
    A098164_SEQUENCE[n] || A098164Builder.sequence(n)[n]
  end

end
