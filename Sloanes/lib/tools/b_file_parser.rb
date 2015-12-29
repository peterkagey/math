require_relative 'helpers/local_b_file'

class BFileParser # Methods that depend on parsing of individual b_files.

  def self.parse(data)
    begin
      BFileParser.new(data)
    rescue StandardError => e
      return puts "Could not parse b-file: " + e.message
    end
  end

  def initialize(data)
    @raw_file = data
  end

  def to_hash
    pairs = rows.map { |str| str.split.map(&:to_i) }
    Hash[pairs]
  end

  def to_ary
    rows.map { |str| str.split.last.to_i }
  end

  def computed_range
    min = rows.first.split.first
    max = rows.last.split.first
    min + ".." + max
  end

  def annotated_range
    range_regex = /^#.*(\d+\.\.\d+)/
    return unless @raw_file =~ range_regex
    @raw_file.match(range_regex)[1]
  end

  private

  def rows
    @rows ||= @raw_file.split("\n").select { |str| str =~ /^\d+ / }
  end

end
