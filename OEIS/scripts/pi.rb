require 'prime'

def pi(n)
  Prime.each(n).to_a.length
end

def pi_mask(n)
  (2**pi(n)) - 1
end
