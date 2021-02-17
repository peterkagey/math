p x = [1,0,1,0,0,0,0,0,0]
print x.reduce(:+), ", "
100.times do |_|
  a, b, c, d, e, f, g, h = x
  x = [
    x.reduce(:+),
    a + b + c + e + f + g,
    x.reduce(:+) + c,
    a + b + c + e + f + g,
    a + b + c + d + e + f,
    a + b + e + f,
    a + b + c + d + e + f,
    a + b + e + f
  ]
  # p x
  print x.reduce(:+), ", "
end


# This counts restricted forests on the 2 x n grid graph where a restricted
# forest is a partition into isolated vertices and paths.
# 2, 15, 95, 604, 3835, 24349, 154594, 981531, 6231827, 39566420, 251210695,
# 1594958889, 10126534850, 64294264119
