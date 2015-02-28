require_relative 'helpers/b_file_to_hash'

class OEIS
  def self.a255167(n)
    # a072905(n) - a006255(n)
    b_file_hash(255167)[n]
  end
end