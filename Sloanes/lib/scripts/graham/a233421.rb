require_relative 'a006255'

class OEIS
  def self.a233421(n)
    nth_nonsquare = n + (0.5 + n**0.5).to_i
    a006255(nth_nonsquare)
  end
end
