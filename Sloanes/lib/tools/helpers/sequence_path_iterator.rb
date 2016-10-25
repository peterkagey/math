require 'pathname'

class PathIterator
  RUBY    = :ruby
  HASKELL = :haskell
  SEQUENCE_FILE_PATTERN = "/*/[aA][0123456789]*\."

  CURRENT_DIRECTORY = Pathname(__FILE__).dirname
  RUBY_ROOT    = 2.times.inject(CURRENT_DIRECTORY) { |d, _| d.parent }.to_path + "/"
  HASKELL_ROOT = 4.times.inject(CURRENT_DIRECTORY) { |d, _| d.parent }.to_path + "/haskellOEIS"
end

class SequencePathIterator < PathIterator

  attr_reader :sequence_paths

  RUBY_PATH_FORMAT    = RUBY_ROOT + "/scripts" + SEQUENCE_FILE_PATTERN + "rb"
  HASKELL_PATH_FORMAT = HASKELL_ROOT + "/src"  + SEQUENCE_FILE_PATTERN + "hs"

  RUBY_SEQUENCES    = Dir[RUBY_PATH_FORMAT].reject { |s| s =~ /(sandbox|helpers)/}
  HASKELL_SEQUENCES = Dir[HASKELL_PATH_FORMAT].reject { |s| s =~ /(sandbox|helpers)/ }

  def initialize(language = RUBY)
    @language = language
    @sequence_paths = sequence_paths_by_language
  end

  def sequence_paths_by_language
    case @language
    when RUBY    then RUBY_SEQUENCES
    when HASKELL then HASKELL_SEQUENCES
    end
  end

  def sequence_path(sequence_number)
    paths = sequence_paths.select { |path| path =~ /#{sequence_number}/i }
    raise "No sequence files found!" if paths.empty?
    raise "Multiple sequence files found: #{paths}" if paths.length > 1
    paths.first
  end

  def id_from_path(file_path)
    sequence_match_data = file_path.to_s.match /\/[ab](\d{6})/i
    return sequence_match_data[1].upcase if sequence_match_data
    raise "Could not extract ID from path: #{file_path}"
  end

  def sequence_numbers
    sequence_paths.map { |path| "#{id_from_path(path)}" }
  end

end

class BFilePathIterator < SequencePathIterator

  RUBY_PATH    = RUBY_ROOT    + "b-files/*"
  HASKELL_PATH = HASKELL_ROOT + "/b-files/*"
  B_FILE_PATHS = (Dir[RUBY_PATH] + Dir[HASKELL_PATH])

  def missing_b_files # sequences with scripts but without b-files
    SequencePathIterator.new
    .sequence_numbers
    .select { |seqeunce_number| !find_b_file(seqeunce_number) }
  end

  def find_b_file(sequence_name)
    sequence_number = sequence_name[/\d+/].rjust(6, '0')
    B_FILE_PATHS.find { |path| path =~ /#{sequence_name}/}
  end

  def script_path_to_b_file(script_path)
    find_b_file(id_from_path(script_path))
  end

end

class OEISTestPathIterator < SequencePathIterator

  RUBY_TEST_PATHS    = Dir[RUBY_ROOT    + "specs" + SEQUENCE_FILE_PATTERN + "rb"]
  HASKELL_TEST_PATHS = Dir[HASKELL_ROOT + "test"  + SEQUENCE_FILE_PATTERN + "hs"]

  def test_paths
    case @language
    when RUBY    then RUBY_TEST_PATHS
    when HASKELL then HASKELL_TEST_PATHS
    end
  end

  def test_file_path(id)
    path = sequence_path(id)
    case @language
    when RUBY    then path.sub("/scripts/", "/specs/").sub(".rb", "_spec.rb")
    when HASKELL then path.sub("/src/"    , "/test/" ).sub(".hs", "Spec.hs")
    end
  end

  def tested_sequences
    test_paths.map { |path| "#{id_from_path(path)}" }
  end

  def untested_sequences
    sequence_numbers - tested_sequences
  end

end
