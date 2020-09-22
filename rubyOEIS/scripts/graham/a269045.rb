require_relative '../helper_sequences/a070229'
require_relative 'a006255'

class OEIS
  # Numbers with the property that A006255(k) = A070229(k).
  def self.a269045(n)
    k, counter = 0, 0
    while k += 1 do
      counter += 1 if a070229(k) != a006255(k)
      return k if counter == n
    end
  end
end
