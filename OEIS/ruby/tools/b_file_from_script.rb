require_relative "helpers/sequence_path_iterator"

class BFileBuilder

  def initialize(sequence_name, min, max)
    validate_and_set_arguments(sequence_name, min, max)
    script_file_path = SequencePathIterator.sequence_path(@sequence_number)
    require script_file_path
  end

  def write_file!
    b_file_path = BFilePathIterator.number_to_path(@sequence_number)
    File.write(b_file_path, b_file_string)
    puts "Wrote a(n) for n = #{@range} to #{b_file_path}."
  end

  private

  def validate_and_set_arguments(sequence_name, min, max)
    @sequence_number = sequence_number(sequence_name)
    validate_sequence_number

    @min = min.to_i if min.is_a?(Integer) || min =~ /^\d+$/
    @max = max.to_i if max.is_a?(Integer) || max =~ /^\d+$/
    validate_sequence_range
  end

  def validate_sequence_number
    if BFilePathIterator.b_file_exists? @sequence_number
      raise "b-file already exists for A#{@sequence_number}."
    elsif @sequence_number.nil?
      raise "Unknown sequence: (#{sequence_name})"
    end
  end

  def validate_sequence_range
    begin
      @range = (@min..@max)
    rescue
      raise "Unknown range: (#{max}..#{min})"
    end
  end

  def sequence_number(sequence_name)
    return unless file_name = sequence_name.match(/[aAbB]*(\d{6})/)
    file_name[1]
  end

  def a(n)
    OEIS.send("a" + @sequence_number, n).to_i
  end

  def b_file_string
    str = ""
    @range.each { |i| str += "#{i} #{a(i)}\n" }
    str
  end

end

x = BFileBuilder.new(ARGV[0], ARGV[1], ARGV[2]).write_file!
