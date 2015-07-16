require_relative 'helpers/b_file_to_hash'

class OEIS
  # a(n) = A072905(n) - A006255(n).
  def self.a255167(n)
    b_file_hash(255167)[n]
  end
end
