require_relative 'a116417'
require_relative 'a271410'

class A271984Builder

  def self.sequence(terms, seed)
    return seed if seed.length >= terms
    (seed.last + 1..Float::INFINITY).inject(seed) do |accum, i|
      return accum if accum.length >= terms
      OEIS.a116417(i) == OEIS.a271410(i) ? accum : accum << i
    end
  end

end

class OEIS
  @@a271984 = [34]

  def self.a271984(n)
    @@a271984 = A271984Builder.sequence(n, @@a271984)
    @@a271984[n - 1]
  end
end
