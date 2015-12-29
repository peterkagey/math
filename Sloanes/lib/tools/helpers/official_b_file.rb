require 'open-uri'

class OfficialBFile

  def initialize(id)
    @id = id[/\d+/].rjust(6, '0')
  end

  def to_hash
    BFileParser.parse(raw_file).to_hash
  end

  def to_ary
    BFileParser.parse(raw_file).to_ary
  end

  def official_metadata
    base = "https://oeis.org/search?q=id:A"
    format = "&fmt=text"
    @metadata ||= open("#{base}#{@id}#{format}") { |f| f.read }
  end

  def metadata_rows
    official_metadata.split("\n")
  end

  def raw_file
    regex = /A#{@id}\/.+\.txt/
    raise "Could not find b-file listed!" unless official_metadata =~ regex
    extension = official_metadata[regex]
    open("https://oeis.org/" + extension) { |f| f.read }
  end

  def range
    range_regex = /^%H.+\d+\.\.\d+/
    b_file_descriptor = metadata_rows.find { |line| line =~ range_regex }
    return "missing (OEIS)" if b_file_descriptor.nil?

    desc, min, max = b_file_descriptor.match(/n = (\d+)\.\.(\d+)/).to_a
    "#{min}..#{max}"
  end

end
