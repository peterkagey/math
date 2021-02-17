class NachoCounter

  def self.fib_sum(n)
    fib = [1, 1]
    (2..n).each { |i| fib << fib[i - 1] + fib[i - 2] }

    s = 0
    fib.map { |a_i| s += a_i }
  end

  FIB_SUM = NachoCounter.fib_sum(50)

  def count(n)
    (0..Float::INFINITY).each do |i|
      return i if n == 0
      index = FIB_SUM.each_index.find { |i| n - FIB_SUM[i] < 0 }
      n -= FIB_SUM[index - 1]
    end
  end

end

counter = NachoCounter.new
x = 30.times.map { |i| counter.count(i) }
