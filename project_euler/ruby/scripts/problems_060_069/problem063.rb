class ProjectEuler

  def self.len(k, b)
    Math.log(k, b).to_i + 1
  end

  def self.problem063(base)
    p max = (1..Float::INFINITY).find { |i| len((base-1)**i, base) < i } - 1
    (1...max).map { |e| (1...base).count { |b| len(b**e, base) == e } }.reduce(:+)
  end

end

# 49
# 0.2 ms
