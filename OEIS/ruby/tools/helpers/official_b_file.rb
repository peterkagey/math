require 'open-uri'

class OfficialBFile

  def initialize(b_file_compare)
    @id = b_file_compare.id
    @b_file_compare = b_file_compare
  end

  def raw
    base = "https://oeis.org/search?q=id:A"
    format = "&fmt=text"
    open("#{base}#{@id}#{format}") { |f| f.read }.split("\n")
  end

  def range
    return @b_file_compare.cached_range if @b_file_compare.cached_range

    range_regex = /^%H.+\d+\.\.\d+/
    b_file_descriptor = raw.find { |line| line =~ range_regex }
    return "missing (OEIS)" if b_file_descriptor.nil?

    desc, min, max = b_file_descriptor.match(/n = (\d+)\.\.(\d+)/).to_a
    "#{min}..#{max}"
  end

end
