require_relative '../helper_sequences/a070229'
require_relative 'a006255'

class OEIS
  # Numbers with the property that A006255(k) = A070229(k).
  def self.a255363(n)
    (0..Float::INFINITY).inject(0) do |counter, k|
      return k if counter == n
      a070229(k + 1) == a006255(k + 1) ? counter + 1 : counter
    end
  end
end
