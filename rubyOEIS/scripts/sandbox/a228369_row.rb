def a228369_row(n)
  (0...2**n/2).map do |k|
    (1...n).inject([1]) do |accum, i|
      next accum << 1 if k[n - 1 - i] == 0
      accum[0...-1] + [accum[-1] + 1]
    end
  end
end

# p a228369_row(1)
# p a228369_row(2)
# p a228369_row(3)
# p a228369_row(4)
# p a228369_row(5)
