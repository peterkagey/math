require 'open-uri'
require_relative 'helpers/sequence_path_iterator'

class BFileCompare

  PENDING_SEQUENCES = {
    "A000000" => "Awaiting naming and upload.",

    "A019555" => "Awaiting upload.",
    "A047932" => "Awaiting upload.",
    "A053797" => "Awaiting upload.",
    "A072905" => "Awaiting upload.",
    "A098164" => "Awaiting upload.",
    "A121341" => "Awaiting upload.",
    "A143051" => "Awaiting upload.",
    "A163325" => "Awaiting upload.",
    "A258448" => "Awaiting upload.",
    "A173902" => "Awaiting upload.",

    "A143480" => "Draft (2015/09/03).",
    "A143481" => "Draft (2015/09/03).",
    "A143483" => "Draft (2015/09/03).",
    "A259439" => "Draft (2015/09/03).",
    "A261863" => "Draft (2015/09/04).",
    "A261865" => "Draft (2015/09/03).",
    "A262036" => "Draft (2015/09/08).",
  }

  attr_reader :local_range, :oeis_range

  def initialize(sequence_id)
    @id = sequence_id
    @local_range = local_range
    @oeis_range = oeis_range
  end

  def skip?
    return true if no_local_b_file?
    false
  end

  def pending?
    !!PENDING_SEQUENCES.find { |name, _| name =~ /#{@id}/}
  end

  def pending_reason
    PENDING_SEQUENCES.find { |name, _| name =~ /#{@id}/}.last rescue "Unknown!"
  end

  def internal_format
    base = "https://oeis.org/search?q=id:A"
    format = "&fmt=text"
    open("#{base}#{@id}#{format}") { |f| f.read }.split("\n")
  end

  def oeis_range
    range_regex = /^%H.+\d+\.\.\d+/
    b_file_descriptor = internal_format.find { |line| line =~ range_regex }
    return "missing" if b_file_descriptor.nil?

    desc, min, max = b_file_descriptor.match(/n = (\d+)\.\.(\d+)/).to_a
    "#{min}..#{max}"
  end

  def local_range
    b_file_path = BFilePathIterator.number_to_path(@id)
    return ".." if !File.exists? b_file_path
    pairs = File.read(b_file_path).split(/\s/).each_slice(2).map(&:first)
    pairs.first + ".." + pairs.last
  end

  def no_local_b_file?
    !!BFilePathIterator.missing_b_files.find { |file| file =~ /#{@id}/ }
  end

end
