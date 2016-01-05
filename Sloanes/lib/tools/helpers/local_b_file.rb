require_relative 'sequence_path_iterator'
require_relative '../b_file_parser'

class LocalBFile # Functions about a particular sequence's local b-file.

  def initialize(id)
    @id = id.to_s[/\d+/].rjust(6, '0')
  end

  def to_hash
    BFileParser.parse(raw_file).to_hash
  end

  def to_ary
    BFileParser.parse(raw_file).to_ary
  end

  def raw_file
    @raw_file ||= File.read(path)
  end

  def missing?
    BFilePathIterator.missing_b_files.find { |file| file =~ /#{@id}/ }
  end

  def annotated_range
    annotation = File.open(path, &:readline)
    regex = /\d+\.\.\d+/
    raise "A#{@id} has a b-file that is not annotated" unless annotation =~ regex
    annotation[regex]
  end

  def range
    lines = raw_file.split("\n").select { |s| s =~ /^\d+ / }
    pairs = lines.map(&:split).map(&:first)
    pairs.first + ".." + pairs.last
  end

  def last_updated
    File.mtime(path)
  end

  def path
    @path ||= BFilePathIterator.find_b_file(@id)
  end

end
