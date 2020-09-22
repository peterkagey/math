class OEIS

  def self.a262343(n)
    k = n/6
    case n % 6
    when 0 then 3  * k - 1 #     n/2 - 1
    when 1 then 18 * k - 3 # 3 * n   - 6
    when 2 then 9  * k     # 3 * n/2 - 3
    when 3 then 6  * k + 1 #     n   - 2
    when 4 then 9  * k + 3 # 3 * n/2 - 3
    when 5 then 18 * k + 9 # 3 * n   - 6
    end

  end

end
