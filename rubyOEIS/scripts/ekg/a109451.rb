require_relative '../helpers/ekg_builder'
require_relative '../helper_sequences/a000120'

class OEIS
  def self.a109451(n)
    case n % 8
    when 0, 1, 6, 7 then n
    when 2, 4       then n + 1
    when 3, 5       then n - 1
    end
  end
end
