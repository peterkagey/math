# I found this on a reddit (?) thread on Friday, September 6, 2019.
# https://www.reddit.com/r/mathriddles/d0du09/
# https://www.reddit.com/r/math/d1x4rq/

# A296062

load '/Users/pk/personal/math/Sloanes/lib/scripts/helpers/sums_and_differences.rb'

def a296062_list(m)
  ary = [nil, 0]
  m.times do
    n = ary.length
    ary << (1..n/2).map { |i| ary[i] + ary[n - i] + n - 2*i }.min
  end
  ary[1..m]
end

def a999999_list(m)
  ary = [nil, 0]
  m.times do
    n = ary.length
    ary << (1..n/2).map { |i| ary[i] + ary[n - i] + i.lcm(n - i) }.min
  end
  ary[1..m]
end

def a999998_list(m)
  ary = [nil, 0]
  m.times do
    n = ary.length
    ary << (1..n/2).map { |i| ary[i] + ary[n - i] + i.gcd(n - i) }.max
  end
  ary[1..m]
end

p a296062_list(30)
p a999999_list(30)
p a999998_list(30)
p a296062_list(30).first_differences
p a999999_list(30).first_differences
p a999998_list(30).first_differences

a999998_list(3000).first_differences.each_with_index { |e, i| puts "#{i}, #{e}" }
# (1..m).zip(ary[1..-1]).each { |i,j| puts "#{i}, #{j}" }

# a = [nil]
# n = 27
# ary << (1..n/2).map { |i| ary[i] + ary[n - i] + n - 2*i }.min

# class Calculator
#
#   def initialize(n)
#     @a = [nil, 0]
#     @n = n
#   end
#
#   def f(k)
#     @a[k] ||= (1..k7/2).map { |i| f(i) + f(k - i) + k - 2*i }.min
#   end
#
# end
