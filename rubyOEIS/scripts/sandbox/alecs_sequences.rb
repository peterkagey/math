require_relative '../helpers/alec_sequences'

class AlecSequences

####################################################################

  def self.s269423(terms = 10) # A269423
    generate(terms, :+, 0) { |a_i, n, i| a_i % i == n % i }
  end

  def self.s271530(terms = 10) # A271530
    generate(terms, :*) { |a_i, n, i| a_i % i == n % i }
  end

  def self.s271531(terms = 10) # A271531
    generate(terms, :lcm) { |a_i, n, i| a_i % i == n % i }
  end

  def self.s269427(terms = 10) # A269427
    generate(terms, :increment, 0) { |a_i, n, i| a_i % i == n % i }
  end

  def self.s271773(terms = 10) # A271773
    generate(terms, :max, 0) { |a_i, n, i| a_i % i == n % i }
  end

  def self.sequence7(terms = 10)
    generate(terms, :^, 0) { |a_i, n, i| a_i % i == n % i }
  end

  # def self.sequence8(terms = 10)
  #   generate(terms, :inverse_sum, Rational(0)) { |a_i, n, i| a_i % i == n % i }
  # end

####################################################################

  def self.s269347(terms = 10) # A269347
    generate(terms, :+, 0) { |a_i, n| n % a_i == 0 }
  end

  def self.s271503(terms = 10) # A271503
    generate(terms, :*) { |a_i, n| n % a_i == 0 }
  end

  def self.s271504(terms = 10) # A271504
    generate(terms, :lcm) { |a_i, n| n % a_i == 0 }
  end

  def self.s088167(terms = 10) # A088167
    generate(terms, :increment, 0, [1], 0) { |a_i, n| n % a_i == 0 }
  end

  def self.s271774(terms = 10) # A271774
    generate(terms, :max, 0) { |a_i, n| n % a_i == 0 }
  end

  # def self.sequence8(terms)
    # generate(terms, :^, 0) { |a_i, n| n % a_i == 0 }
  # end

####################################################################

  def self.s096216(terms = 10) # A096216
    generate(terms, :increment, 0) { |a_i, n| a_i.gcd(n) == 1 }
  end

  def self.sequence1(terms = 10)
    generate(terms, :+, 0) { |a_i, n| a_i.gcd(n) == 1 }
  end

####################################################################

  def self.s133265(terms = 100) # A133265
    generate(terms, :increment, e = 0, [0, 1], 0) { |a_i, n| (n ^ a_i).even? }
  end

  def self.sequence2(terms = 10)
    generate(terms, :+, e = 0, [0,1], 0) { |a_i, n| (n ^ a_i).even? }
  end


####################################################################

  def self.sequence3(terms = 10)
    generate(terms, :+, e = 0, given = [0], off = 0) { |a_i, n| (n ^ a_i).odd? }
  end

##############################################################################

  def self.sequence4(terms = 10)
    generate(terms, :+, 0, [1]) { |a_i, n| a_i.gcd(n) != 1 }
  end

  def self.sequence5(terms = 10)
    generate(terms, :max, 0, [1]) { |a_i, n| a_i.gcd(n) != 1 }
  end

  def self.sequence6(terms = 10)
    generate(terms, :increment, 0, [2]) { |a_i, n| a_i.gcd(n) != 1 }
  end

end

(1..12).each do |i|
  seq = "sequence#{i}"
  puts "#{seq}: #{AlecSequences.send(seq, 20)}" rescue (puts seq; next)
end

