class SequencePathIterator

  def self.sequence_paths
    current_directory = File.dirname(__FILE__)
    parent_directory = File.dirname(current_directory)
    path = File.dirname(parent_directory) + "**/scripts/*/a*.rb"
    Dir[path]
  end

  def self.sequence_path(sequence_number)
    sequence_paths.find { |path| path =~ /a#{sequence_number}.rb/ }
  end

  def self.extract_number(file_path)
    sequence_match_data = file_path.match /\/[ab](\d{6})\.(rb|txt)/
    return sequence_match_data[1].upcase if sequence_match_data
    ""
  end

  def self.sequence_numbers
    sequence_paths.map { |path| extract_number(path) }
  end

end

class BFilePathIterator < SequencePathIterator

  def self.b_file_paths
    sequence_paths.map { |path| script_path_to_b_file(path) }
  end

  def self.missing_b_files
    missing = b_file_paths.select { |path| !File.exists? path }
    missing.map { |path| "b" + extract_number(path) }
  end

  def self.b_file_exists?(sequence_number)
    File.exists? number_to_path(sequence_number)
  end

  def self.number_to_path(sequence_number)
    b_file_path = "/Users/pkagey/personal/math/OEIS/b-files/b"
    extension = ".txt"
    b_file_path + sequence_number + extension
  end

  def self.script_path_to_b_file(script_path)
    number_to_path SequencePathIterator.extract_number(script_path)
  end

end

class OEISTestPathIterator < SequencePathIterator

  def self.spec_file_path(file_path)
    file_path.sub("/scripts/", "/specs/").sub(".rb", "_spec.rb")
  end

  def self.untested_sequences
    missing = sequence_paths.select { |path| !File.exist? spec_file_path(path) }

    missing.map { |i| "A" + extract_number(i) }
  end

end
