# Number of colorings of an nxn grid of k-in-a-row.

# x o o o
# o x o o
# o o x o
# o o o o

def t(n, k) # recursive
  return n * n     if k == 1
  return 0         if n < k
  return 2 * n + 2 if k == n
  2 * t(n - 1, k) - t(n - 2, k) + 8
end

def t2(n, k) # non-recursive
  return n * n if k == 1
  return 0     if n < k - 1

  2 * (k - 1)**2 +
  4 * n * n -
  6 * (k - 1) * n
end
