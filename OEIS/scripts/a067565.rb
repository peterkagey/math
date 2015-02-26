require_relative 'b_file_to_hash'
class OEIS

  INVERSE_A006255_HASH = b_file_hash(67565)

  def self.a067565(n)
    INVERSE_A006255_HASH[n]
  end

end
