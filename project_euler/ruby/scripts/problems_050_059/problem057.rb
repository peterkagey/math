class ProjectEuler

  def self.problem057
    d = ->(n, s) { (n + 1).send(s).to_s.length }
    999.times.
      inject([Rational(0.5)]) { |a, _| a << (a.last + Rational(2))**-1 }.
      count { |n| d.call(n, :numerator) > d.call(n, :denominator) }
  end
end

# 153
# 0.17996 s
