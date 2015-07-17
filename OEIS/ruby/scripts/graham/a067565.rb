require_relative '../helpers/b_file_to_hash'

class OEIS

  # Inverse of Ron Graham's sequence (A006255), or zero if and only if n is a
  # prime.
  def self.a067565(n)
    inverse_hash[n]
  end

  def self.inverse_hash
    @inverse_hash ||= b_file_hash(67565)
  end
  private_class_method :inverse_hash

end
