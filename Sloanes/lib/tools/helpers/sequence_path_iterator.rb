require 'pathname'

class SequencePathIterator

  RUBY    = :ruby
  HASKELL = :haskell
  SEQUENCE_FILE_PATTERN = "/*/[aA][0123456789]*."

  attr_reader :sequence_paths

  def root
    case @language
    when RUBY    then File.expand_path("../" * 3 + "scripts",     __FILE__)
    when HASKELL then File.expand_path("../" * 5 + "haskellOEIS", __FILE__)
    end
  end

  def ext
    case @language
    when RUBY    then "rb"
    when HASKELL then "hs"
    end
  end

  def initialize(language = RUBY)
    @language = language
    path = root + SEQUENCE_FILE_PATTERN + ext
    @sequence_paths = Dir[path].reject { |s| s =~ /(sandbox|helpers)/ }
  end

  def sequence_path(sequence_number)
    sequence_paths.find { |path| path =~ /#{sequence_number}/i }
  end

  def id_from_path(file_path)
    sequence_match_data = file_path.to_s.match /\/[ab](\d{6})/i
    return sequence_match_data[1].upcase if sequence_match_data
    raise "Could not extract ID from path: #{file_path}"
  end

  def sequence_numbers
    sequence_paths.map { |path| "A#{id_from_path(path)}" }
  end

end


class BFilePathIterator < SequencePathIterator

  def b_file_paths # with corresponding script files
    sequence_paths.map { |path| script_path_to_b_file(path) }
  end

  def missing_b_files # script files without matching b-file
    missing = b_file_paths.select { |path| !File.exists? path }
    missing.map { |path| "b" + id_from_path(path) }
  end

  def b_file_exists?(sequence_number)
    File.exists? find_b_file(sequence_number)
  end

  def find_b_file(sequence_name)
    sequence_number = sequence_name[/\d+/].rjust(6, '0')
    root = Pathname(__FILE__).dirname.parent.parent
    root + "b-files" + "b#{sequence_number}.txt"
  end

  def script_path_to_b_file(script_path)
    find_b_file(id_from_path(script_path))
  end

end

class OEISTestPathIterator < SequencePathIterator

  def test_paths
    @test_paths ||= Dir[test_root + SEQUENCE_FILE_PATTERN + ext]
  end

  def test_file_path(id)
    path = sequence_path(id)
    case @language
    when RUBY
      path.sub("/scripts/", "/specs/").sub(".rb", "_spec.rb")
    when HASKELL
      path.sub("haskellOEIS/", "haskellOEIS/Tests/").sub(".hs", "Test.hs")
    end
  end

  def tested_sequences
    test_paths.map { |path| "A#{id_from_path(path)}" }
  end

  def untested_sequences
    sequence_numbers - tested_sequences
  end

  private

  def test_root
    case @language
    when RUBY    then File.expand_path("../" * 3 + "specs",             __FILE__)
    when HASKELL then File.expand_path("../" * 5 + "haskellOEIS/Tests", __FILE__)
    end
  end

end
