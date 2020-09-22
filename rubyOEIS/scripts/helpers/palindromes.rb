class Palindromes
  attr_reader :n, :b

  def self.base(b)
    Palindromes.new(2, b)
  end

  def self.length(n)
    Palindromes.new(n, 3)
  end

  def base(b)
    @b = b
    self
  end

  def length(n)
    @n = n
    self
  end

  def initialize(n, b)
    @n = n
    @b = b
  end

  def all
    pals = @n.odd? ? odd_palindromes : even_palindromes
    pals.map { |s| s.to_i(b) }
  end

  private

  def string_to_even_palindrome(str)
    str + str.reverse
  end

  def string_to_odd_palindrome(str)
    str[0...-1] + str.reverse
  end

  def odd_palindromes
    min = b**(n/2)
    max = b**(n/2 + 1)

    (min...max).map { |i| string_to_odd_palindrome i.to_s(b) }
  end

  def even_palindromes

    min = b**(n/2 - 1)
    max = b**(n/2) - 1

    (min..max).map { |i| string_to_even_palindrome i.to_s(b) }
  end
end

class IntrinsicKPalindromes

  def initialize(k, terms)
    @k = k
    @terms = terms
  end

  def all
    list = []
    b = 2
    b += 1 until beginning(list) == beginning(list += new_terms(b))

    beginning(list)
  end

  private

  def beginning(lst)
    lst.sort.uniq[0...@terms]
  end

  def new_terms(b)
    Palindromes.base(b).length(@k).all
  end
end
