class OEIS

  def self.a000002(n)
    a000002_seq(n).last
  end

  def self.a000002_seq(n)
    a = [1, 2, 2]
    index = 1

    while a.length <= n do
      index += 1
      a_i = (a.last == 1) ? 2 : 1
      a[index].times { |i| a << a_i }
    end

    a[0..n]
  end
end

class A000002TreeDrawer

  def initialize(term_count)
    @term_count = term_count
  end

  def a000002
    @a000002 ||= OEIS.a000002_seq(@term_count)
  end

  def line_array
    b = []
    count = 0
    a000002.each_index do |i|
      base_char = (a000002[i] == 1) ? "| " : "V "
      count += 1 if i == 0 || a000002[i-1] == 2
      b << (base_char * count).strip
    end
    b
  end

  def max_string_width
    @max_string_width ||= line_array[-1].length
  end

  def center(str)
    margin_width = (max_string_width - str.length)/2
    " " * margin_width + str
  end

  def to_s
    line_array.reverse.map { |line| center(line) }.join("\n")
  end

end
