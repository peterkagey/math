def count_rectangles(m, n)
  histogram = (1..m).flat_map do |x|
    (1..n).map do |y|
      (m - x + 1) * (n - y + 1)
    end
  end
  histogram.reduce(:+)
end
