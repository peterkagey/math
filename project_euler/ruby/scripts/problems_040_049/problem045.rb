start = Time.now
# All Hexagonal numbers are triangular; so triangularity is superfluous.

def is_pent?(k)
  # 3 * n**2 - n - 2k = 0 where n is an integer
  # 1 +- sqrt(1 - 4*3*(-2k)) / 6
  # 1 + 24*k must be a perfect square and 1 + sqrt(24*k) % 6 == 0
  (Math.sqrt(1 + 24*k).to_i)**2 == 1 + 24*k &&
  (1 + Math.sqrt(1 + 24*k)) % 6 == 0
end

def h(n); n * (2*n -1) end

n = 143
loop do
  n += 1
  if is_pent?(h(n))
    p h(n)
    break
  end
end

p Time.now - start

# 1533776805
# 0.015366 seconds
