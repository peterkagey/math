require_relative '../power_divisibility/a072905'
require_relative '../graham/a006255'
class OEIS

  def self.a255167(n)
    a072905(n) - a006255(n)
  end
end
