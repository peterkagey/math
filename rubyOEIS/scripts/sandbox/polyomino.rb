# This counts the number of polyominos on a 3 X N grid that span the grid.
#. e.g.
#   ██ ████  ███
#    ████ █   █
#   ██  ███████
#   3 X 12 grid.
def next_generation(current)
  a1, a2, b2, a3, a4, a5, b5, a6 = current
  [
    a1 + a4, # a_1
    a1 + a2 + a4 + a5, # a_2
    a1 + b2 + a4 + b5, # b_2
    a3 + a4 + a5 + b5, # a_3
    a1 + a2 + b2 + a3 + a4 + a5 + b5 + a6, # a_4
    a1 + a2 + a3 + a4 + a5 + b5, # a_5
    a1 + b2 + a3 + a4 + a5 + b5, # b_5
    a2 + b2 + a5 + b5 + a6  # a_6
  ]
end

x = (1..10).reduce([[0, 1, 1, 1, 1, 1, 1, 1]]) do |accum, _|
  accum + [next_generation(accum.last)]
end

p x.map { |s| s[0...-1].reduce(:+) }

def next_generation2(current)
  a, b, c = current
  [
    a + b + c,
    a + b,
    a + c
  ]
end

x = (1..20).reduce([[1, 1, 1]]) do |accum, _|
  accum + [next_generation2(accum.last)]
end

p x.map { |s| s.reduce(:+) }
