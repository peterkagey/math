def pairs(n)
  a = n.to_s.split("")
  a[0...-1].zip(a[1..-1])
end

def is_bouncy?(n)
  neighbors = pairs(n)
  !neighbors.all? { |x, y| x <= y } && !neighbors.all? { |x, y| x >= y }
end

x = (2...Float::INFINITY).reduce([1,0]) do |accum, x|
  n, k = accum
  # p "#{n}/#{k}"
  if k.to_r/n == 99.to_r/100
    break n
  elsif is_bouncy?(x)
    [n + 1, k + 1]
  else
    [n + 1, k]
  end
end

puts x

# A man or woman
