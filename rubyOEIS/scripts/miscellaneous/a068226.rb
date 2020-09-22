require_relative 'a174344'
require_relative 'a268038'

def inverse(x,y)
  level = [x.abs, y.abs].max
  if y == level
    (2 * level + 1)**2 + x - level
  elsif x == -level
    (2 * level + 1)**2 + x + y - 2 * level
  elsif y == -level
    (2 * level + 1)**2 + y - x - 4 * level
  else
    (2 * level + 1)**2 - x - y - 6 * level
  end
end

def a068225(n)
  inverse(OEIS.a174344(n) + 1, OEIS.a268038(n))
end

def a068226(n)
  inverse(OEIS.a174344(n) - 1, OEIS.a268038(n))
end

def a334751(n)
  inverse(OEIS.a174344(n), OEIS.a268038(n) + 1)
end

def a334752(n)
  inverse(OEIS.a174344(n), OEIS.a268038(n) - 1)
end

# puts (1..200).map { |i| a334752(i) - 1}.join(", ")[0..260]


(1..10000).each { |i| puts "#{i} #{a334752 i}"}
