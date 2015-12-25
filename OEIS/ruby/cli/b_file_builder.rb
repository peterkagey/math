class BFileBuilder

  def self.build(sequence_name, min, max)
    begin
      BFileBuilder.new(sequence_name, min, max).update_b_file!
    rescue StandardError => e
      return puts e.message
    end
  end

  def initialize(sequence_name, min, max)
    @id = "A" + sequence_name[/\d+/].rjust(6, '0')
    @min, @max = [min, max].map(&:to_i)

    validate_and_require_file!
    define_function!
    validate_range!
  end

  def update_b_file!
    BFilePathIterator.b_file_exists?(@id) ? annotate_b_file! : write_b_file!
  end

  private

  PROJECT_ROOT = File.dirname(File.dirname(__FILE__))
  require PROJECT_ROOT + "/tools/helpers/sequence_path_iterator"
  require PROJECT_ROOT + "/tools/b_file_parser"

  def annotate_b_file!
    if annotated_range
      puts "#{@id} already has an annotated b-file! (#{annotated_range})"
    else
      File.write(b_file_path, annotation(computed_range) + @raw_data)
      puts "#{@id}'s b-file was annotated:\n#{annotation(computed_range)}"
    end
  end

  def annotated_range
    @raw_data ||= File.read(b_file_path)
    @annotated_range ||= BFileParser.parse(@raw_data).annotated_range
  end

  def annotation(range)
    "# Table of n, #{@id}(n) for n = #{range}.\n"
  end

  def b_file_path
    BFilePathIterator.find_b_file(@id)
  end

  def computed_range
    @raw_data ||= File.read(b_file_path)
    @computed_range ||= BFileParser.parse(@raw_data).computed_range
  end

  def computed_data
    (@min..@max).map { |i| "#{i} #{@a.yield(i)}" }.join("\n")
  end

  def define_function!
    @a = ->(n){OEIS.send(@id.downcase, n)}
  end

  def validate_and_require_file!
    begin
      require SequencePathIterator.sequence_path(@id)
    rescue
      raise "Could not find function definition file for #{@id}."
    end
  end

  def validate_range!
    raise "Invalid range!" if @min.nil? || @max.nil?
  end

  def write_b_file!
    File.write(b_file_path, annotation(@min..@max) + computed_data)
    puts "Wrote b-file for #{@id} (#{@min..@max}) to #{b_file_path}."
  end

end

BFileBuilder.build(ARGV[0], ARGV[1], ARGV[2])
