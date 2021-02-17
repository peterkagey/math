require '/Users/pkagey/personal/math/Sloanes/lib/scripts/helpers/table.rb'
# http://math.stackexchange.com/questions/1897045/greatest-common-divisor-sequence/1897046
# Cf. A051190, A092287
def t1(n, m)
  (1..m).map { |i| i.gcd(n) }.reduce(:*)
end

def t2(n, m)
  (0..m).map { |i| i.gcd(n) }.reduce(:*)
end

def a1(i)
  # 1 indexed
  n, k = OEISTable.n_k(i - 1).map(&:next)
  t1(n, k)
end

def a2(i)
  # 0 indexed
  n, k = OEISTable.n_k(i)
  t2(n, k)
end

def a3(i)
  # 1_indexed
  n, k = OEISTable.n_k(i - 1).map(&:next)
  t2(n, k)
end


# def a2
p (1..100).map { |i| a1(i) }.join(", ")[0...260]
