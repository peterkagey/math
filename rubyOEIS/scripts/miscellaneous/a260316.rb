class OEIS
  def self.a260316(n)
    n % 3 == 0 ? n/3 : n - 1
  end
end
