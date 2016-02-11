class Integer
  def choose(k)
    k = [k, self-k].max
    numerator = (k + 1..self).reduce(:*) || 1
    denominator = (1..self-k).reduce(:*) || 1
    numerator / denominator
  end
end
