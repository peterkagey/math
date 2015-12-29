class EnglishNumber

  ONES = {
    0 => "",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine"
  }

  TEENS = {
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen"
  }

  TENS = {
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }

  def initialize(n)
    @n = n
  end

  def to_s
    word = thousands_place + hundreds_place + optional_and + tens_place
    word.strip
  end

  private
  def tens_place
    return "zero" if @n == 0
    k = @n % 100
    ones_digit = ONES[k % 10]
    return ONES[k] || TEENS[k] if k < 20

    suffix = ones_digit == "" ? "" : "-" + ones_digit
    TENS[k/10] + suffix
  end

  def hundreds_place
    digit = (@n/100 % 10)
    return "" if digit == 0
    ONES[digit] + " hundred "
  end

  def thousands_place
    digit = (@n/1000 % 10)
    return "" if digit == 0
    ONES[digit] + " thousand "
  end

  def optional_and
    return " " if tens_place == ""
    return ""  if @n < 100
    "and "
  end

end
