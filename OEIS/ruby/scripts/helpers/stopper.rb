class Stopper

  attr_reader :count

  def initialize(subtrahend, divisor, n)
    @subtrahend, @divisor, @n, @count = subtrahend, divisor, n, 0
  end

  def calculate!
    return special_case_computation if @subtrahend == 1
    @count += 1 while iterate
    @count
  end

  private

  def special_case_computation
    base_divisor_representation = @n.to_s(@divisor)
    digit_sum = base_divisor_representation.split('').map(&:to_i).reduce(:+)
    @count = base_divisor_representation.length + digit_sum - 1
  end

  def iterate
    return if @n == 0
    case
    when @n % @divisor == 0 then @n /= @divisor
    when @n >= @subtrahend  then @n -= @subtrahend
    end
  end

end

def stopper(subtrahend, divisor, n)
  Stopper.new(subtrahend,divisor,n).calculate!
end
