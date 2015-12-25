PROJECT_ROOT = File.dirname(File.dirname(__FILE__))
require PROJECT_ROOT + "/tools/helpers/sequence_path_iterator"
require PROJECT_ROOT + "/tools/helpers/local_b_file"
require PROJECT_ROOT + "/tools/helpers/official_b_file"

class TestBuilder

  def initialize(sequence_id)
    return puts "Sequence ID must be included!" if sequence_id.nil?
    @sequence_number = sequence_id[/\d{6}$/]
    write_test unless test_already_exists?
  end

  private

  def test_already_exists?
    if File.exist?(spec_file_path)
      puts "A test for A#{@sequence_number} already exists!"
      true
    else
      false
    end
  end

  def helpers_directory_root
    File.dirname(__FILE__)
  end

  def script_path
    SequencePathIterator.sequence_path(@sequence_number)
  end

  def spec_file_path
    OEISTestPathIterator.spec_file_path(script_path)
  end

  def sequence_hash
    return @sequence_hash if @sequence_hash
    begin
      @sequence_hash ||= OfficialBFile.new(@sequence_number).to_hash
      puts "Building test from official file."
    rescue
      @sequence_hash ||= LocalBFile.new(@sequence_number).to_hash
      puts "Building test from local file."
    end
    @sequence_hash
  end

  def minimum_argument
    sequence_hash.keys.min
  end

  def r # range (first five values)
    (minimum_argument...minimum_argument+5).to_a
  end

  def test
    @test ||= %(require_relative '../../#{script_path[/script.+/][0...-3]}'

describe OEIS do

  def a(n)
    OEIS.a#{@sequence_number}(n)
  end

  it "should know first five values" do
    expect(a(#{r[0]})).to eq #{sequence_hash[r[0]]}
    expect(a(#{r[1]})).to eq #{sequence_hash[r[1]]}
    expect(a(#{r[2]})).to eq #{sequence_hash[r[2]]}
    expect(a(#{r[3]})).to eq #{sequence_hash[r[3]]}
    expect(a(#{r[4]})).to eq #{sequence_hash[r[4]]}
  end

end
)
  end

  def write_test
    puts test
    File.write(spec_file_path, test)
    "Successfully wrote a test to #{spec_file_path}"
  end

end

TestBuilder.new(ARGV[0])