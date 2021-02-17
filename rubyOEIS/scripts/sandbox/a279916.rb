require 'open-uri'

a279688 = open("https://oeis.org/A279688/b279688.txt").read.split(/\s/).each_slice(2).map(&:last).map(&:to_i)

class Integer
  def to_base(b)
    return [0] if self == 0
    (0..Float::INFINITY).
      lazy.
      map { |i| b**i }.
      reduce([]) { |a, d| break a if d > self; a.unshift(self/d % b) }
  end
end

def find_palindrome_base(a_n)
  (3..a_n).each do |b|
    return b if a_n.to_base(b).sort == (2 * a_n).to_base(b).sort
  end
  throw "Nothing matched for #{a_n}!"
end

a279688[1..-1].each_with_index { |a_i, i| p [i + 2, find_palindrome_base(a_i)] }
