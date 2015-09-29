class OEISTable

  def self.collect_coordinates(terms = 10)
    coordinate_list = []
    (0..terms).each do |i|
      n, k = n_k(i)
      coordinate_list << yield(n - 1, k - 1)
    end
    coordinate_list
  end

  def self.triangle(n)
    n * (n + 1)/2
  end

  def self.ith_triangle_number_less_than(n)
    0.5 * ((8 * n + 1)**0.5 - 1)
  end

  def self.n_k(j)
    i = (ith_triangle_number_less_than j).to_i
    k = j - triangle(i) + 1
    n = i - k + 2
    [n, k]
  end

end

p OEISTable.collect_coordinates(20) { |n, k| n | k }
