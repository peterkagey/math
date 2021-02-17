import itertools

def f(word): # Corresponds to tree [1] x [2] x ... x [n].
  permutation = [1]
  for i in range(1,len(word)):
    x = word[i]
    permutation.insert(x - 1, i + 1)
  return permutation[::-1]

def g(word): # Corresponds to tree [n] x ... x [2] x [1].
  letters = list(range(1,len(word)+1))
  permutation = []
  for x in word[::-1]:
    permutation.append(letters[x-1])
    letters.pop(x-1)
  return permutation

def words(n): # Words of [1] x [2] x ... x [n]
  return list(itertools.product(*list(map(lambda i: list(range(1,i+2)), range(n)))))

# def words2(n): # Words of [n] x ... x [2] x [1].
#   return list(map(lambda l: l[::-1],itertools.product(*map(lambda i: range(1,n+1-i), range(n)))))

def count_fixed_points(n):
  c = 0
  for w in words(n):
    if g(w) == f(w):
      c += 1
      print(c, g(w), w)
  return c

count_fixed_points(4)
