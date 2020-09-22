class A258448

  MAX_THRESHOLD = 1000

  def initialize
    @a = Hash.new
    @a[5] = 0
    expand
  end

  def find_preimage_of_k(k)
    @a.select { |domain, codomain| codomain == k }.keys.each { |i| yield i }
  end

  def products_from(k)
    product_bank = []
    (0..k/2).each do |i|
      n = i * (k - i)
      break if n > MAX_THRESHOLD
      product_bank << n
    end
    product_bank
  end

  def expand
     (0..10).each do |foo|
      find_preimage_of_k(foo) do |i|
        products_from(i).each { |i| @a[i] ||= foo + 1 }
      end
    end
  end

  def to_a
    @a.to_a.sort.map(&:last)
  end

end

class OEIS

  A258448_SEQUENCE = A258448.new.to_a

  def self.a258448(n)
    A258448_SEQUENCE[n]
  end
end
