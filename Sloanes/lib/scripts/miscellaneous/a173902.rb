class A173902Builder

  def self.sequence(target_length = 100)
    a173902 = []
    i = 1
    while a173902.length < target_length
      a173902 << i if member?(i)
      i += 1
    end
    a173902
  end

  def self.each_digit_cubed(n)
    "#{n}".split("").uniq.each { |i| yield (i.to_i**3) }
  end

  def self.member?(n)
    each_digit_cubed(n) do |i|
      return false unless "#{n**3}" =~ /#{i}/
    end
    true
  end

end

class OEIS

  A173902_SEQUENCE = A173902Builder.sequence

  def self.a173902(n)
    raise "A173902 is not defined for n = #{n}" if n < 1
    A173902_SEQUENCE[n - 1] || A173902Builder.sequence(n).last
  end
end
