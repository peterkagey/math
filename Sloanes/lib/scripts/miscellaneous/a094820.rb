class OEIS

  def self.a094820(n)
    (1..Math.sqrt(n)).inject(0) { |accum, i| accum + 1 + (n/i).to_i - i }
  end

end
