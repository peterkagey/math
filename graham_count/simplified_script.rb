require_relative '../OEIS/scripts/a248663'
require_relative '../OEIS/scripts/a006255'
class Array

  def subset(index)
    sub_array = []
    (0...index.bit_length).each { |j| sub_array << self[j] if index[j] == 1 }
    sub_array
  end

  def each_subset(&block)
    (0...2**length).each { |i| yield(subset(i)) }
  end

end

def a248663(n); OEIS.a248663(n) end
def g(n);       OEIS.a006255(n) end

def a(n)
  counter = 0
  set = (n+1...g(n)).to_a
  target = a248663(n) ^ a248663(g(n))

  set.each_subset do |subset|
    counter += 1 if subset.map { |a_i| a248663(a_i) }.reduce(:^) == target
  end
  counter
end
