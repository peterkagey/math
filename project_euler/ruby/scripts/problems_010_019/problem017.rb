class Problem017Helper

  def ones_name(n)
    a = [
      "",
      "one",
      "two",
      "three",
      "four",
      "five",
      "six",
      "seven",
      "eight",
      "nine"
    ]
    a[n]
  end

  def tens_name(n)
    return ones_name(n) if n < 10
    b = {
      10 => 'ten',
      11 => 'eleven',
      12 => 'twelve',
      13 => 'thirteen',
      14 => 'fourteen',
      15 => 'fifteen',
      16 => 'sixteen',
      17 => 'seventeen',
      18 => 'eighteen',
      19 => 'nineteen'
    }
    return b[n] if n < 20
    c = {
      20 => 'twenty',
      30 => 'thirty',
      40 => 'forty',
      50 => 'fifty',
      60 => 'sixty',
      70 => 'seventy',
      80 => 'eighty',
      90 => 'ninety'
    }
    c[n/10 * 10] + ones_name(n % 10)
  end

  def hundreds_name(n)
    return "onethousand" if n == 1000
    hundreds_place = ones_name(n/100) + "hundred" unless ones_name(n/100) == ""
    hundreds_place ||= ""
    hundreds_place += "and" unless n % 100 == 0 || n < 100
    hundreds_place + tens_name(n % 100)
  end

end

class ProjectEuler

  def self.problem017
    helper = Problem017Helper.new
    x = (1..1000).collect do |i|
      helper.hundreds_name(i)
    end

    x.join.length
  end

end
