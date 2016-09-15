PROJECT_ROOT = File.dirname(File.dirname(__FILE__))
require PROJECT_ROOT + "/tools/helpers/sequence_path_iterator"
require PROJECT_ROOT + "/tools/helpers/local_b_file"
require PROJECT_ROOT + "/tools/helpers/official_b_file"

class TestBuilder

  def initialize(sequence_id, number_of_terms = nil, language = :ruby)
    return puts "Sequence ID must be included!" if sequence_id.nil?
    @language = language
    @sequence_number = sequence_id[/\d{6}$/]
    return puts "Could not parse sequence number!" if @sequence_number.nil?
    @number_of_terms = (number_of_terms || 5)
    @iterator = OEISTestPathIterator.new(@language)
    write_test unless abort_test?
    puts `#{test_command} #{spec_file_path}`
  end

  def test_command
    case @language
    when :ruby then "bundle exec rspec"
    when :haskell then "runhaskell -isrc -itest"
    end
  end

  private

  def abort_test?
    if sequence_missing?
      puts "A script for this sequence does not exist."
      true
    elsif File.exist?(spec_file_path)
      puts "A test for A#{@sequence_number} already exists!"
      true
    else
      false
    end
  end

  def helpers_directory_root
    File.dirname(__FILE__)
  end

  def sequence_path
    @seq_path ||= @iterator.sequence_path(@sequence_number)
  end

  def spec_file_path
    @spec_path ||= @iterator.test_file_path(@sequence_number)
  end

  def sequence_missing?
    sequence_path.nil?
  end

  def a
    return @sequence_hash if @sequence_hash
    begin
      @sequence_hash ||= OfficialBFile.new(@sequence_number).to_hash
      puts "Building test from official file."
    rescue StandardError => e
      @sequence_hash ||= LocalBFile.new(@sequence_number).to_hash
      puts "Could not build from official file: " + e.message
      puts "Building test from local file."
    end
    @sequence_hash
  end

  def minimum_argument
    a.keys.min
  end

  def range
    (0...@number_of_terms.to_i).map { |i| i + minimum_argument }
  end

  def write_test
    puts test
    File.write(spec_file_path, test)
    "Successfully wrote a test to #{spec_file_path}"
  end

end
