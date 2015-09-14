require_relative 'a005117'
require_relative 'a261865'

class A262036Builder

  def self.sequence(target_length = 25)
    inverse_hash = {}
    (2...target_length + 2).each { |i| inverse_hash[OEIS.a005117(i)] = i }

    a262036 = Array.new(target_length + 2)
    i = 0
    while (a262036[2..-1].include? nil) && (i += 1)
      a261865_i = OEIS.a261865(i)
      index = inverse_hash[a261865_i]
      a262036[index] ||= i unless index.nil?
    end
    a262036[2..-1]
  end

end

class OEIS

  A262036_SEQUENCE = A262036Builder.sequence

  def self.a262036(n)
    A262036_SEQUENCE[n - 2] || A262036Builder.sequence(n-1)[n-2]
  end

end
