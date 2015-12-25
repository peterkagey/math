require 'open-uri'

class OfficialBFile

  def initialize(id)
    @id = id
  end

  def to_hash
    BFileParser.parse(raw_file).to_hash
  end

  def to_ary
    BFileParser.parse(raw_file).to_ary
  end

  def raw_file
    base = "https://oeis.org/search?q=id:A"
    format = "&fmt=text"
    open("#{base}#{@id}#{format}") { |f| f.read }
  end

  def rows
    raw_file.split("\n")
  end

  def range
    range_regex = /^%H.+\d+\.\.\d+/
    b_file_descriptor = rows.find { |line| line =~ range_regex }
    return "missing (OEIS)" if b_file_descriptor.nil?

    desc, min, max = b_file_descriptor.match(/n = (\d+)\.\.(\d+)/).to_a
    "#{min}..#{max}"
  end

end
