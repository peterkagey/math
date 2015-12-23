require_relative '../helpers/b_file'

class OEIS

  # Inverse of Ron Graham's sequence (A006255), or zero if and only if n is a
  # prime.
  def self.a067565(n)
    inverse_hash[n]
  end

  def self.inverse_hash
    @inverse_hash ||= BFile.new(67565).to_hash
  end
  private_class_method :inverse_hash

end
