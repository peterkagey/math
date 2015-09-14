require_relative "download_hash"

class TestBuilder

  def initialize(sequence_id)
    @id = "a" + sequence_id.to_s[/\d+/].rjust(6, '0')
    write_test unless test_already_exists?
  end

  def test_already_exists?
    if File.exist?(spec_file_path)
      puts "Test already exists for #{@id}!"
      true
    else
      false
    end
  end

  def helpers_directory_root
    File.dirname(__FILE__)
  end

  def spec_file_path
    helpers_directory_root + "/../../specs/#{@id}_spec.rb"
  end

  def sequence_hash
    @sequence_hash ||= seq_to_hash(@id)
  end

  def minimum_argument
    sequence_hash.keys.min
  end

  def r # range (first five values)
    (minimum_argument...minimum_argument+5).to_a
  end

  def test
    %(require_relative '../scripts/#{@id}'

describe OEIS do

  def a(n)
    OEIS.#{@id}(n)
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
    File.write(spec_file_path, test)
  end

end

TestBuilder.new(ARGV[0])
