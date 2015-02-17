require_relative 'b_file_hash'

class OEIS
  def self.a255167(n)
    # a072905(n) - a006255(n)
    b_file_hash(255167)[n]
  end
end