require 'pathname'

class SequencePathIterator

  def self.sequence_paths
    current_directory = File.dirname(__FILE__)
    parent_directory = File.dirname(current_directory)
    path = File.dirname(parent_directory) + "**/scripts/*/a[0123456789]*.rb"
    Dir[path]
  end

  def self.sequence_path(sequence_number)
    sequence_paths.find { |path| path =~ /#{sequence_number}.rb/i }
  end

  def self.id_from_path(file_path)
    sequence_match_data = file_path.to_s.match /\/[ab](\d{6})\.(rb|txt)/
    return sequence_match_data[1].upcase if sequence_match_data
    raise "Could not extract ID from path: #{file_path}"
  end

  def self.sequence_numbers
    sequence_paths.map { |path| id_from_path(path) }
  end

end


class BFilePathIterator < SequencePathIterator

  def self.b_file_paths # with corresponding script files
    sequence_paths.map { |path| script_path_to_b_file(path) }
  end

  def self.missing_b_files # script files without matching b-file
    missing = b_file_paths.select { |path| !File.exists? path }
    missing.map { |path| "b" + id_from_path(path) }
  end

  def self.b_file_exists?(sequence_number)
    File.exists? find_b_file(sequence_number)
  end

  def self.find_b_file(sequence_name)
    sequence_number = sequence_name[/\d+/].rjust(6, '0')
    root = Pathname(__FILE__).dirname.parent.parent
    root + "b-files" + "b#{sequence_number}.txt"
  end

  def self.script_path_to_b_file(script_path)
    find_b_file(SequencePathIterator.id_from_path(script_path))
  end

end

class OEISTestPathIterator < SequencePathIterator

  def self.spec_file_path(file_path)
    file_path.sub("/scripts/", "/specs/").sub(".rb", "_spec.rb")
  end

  def self.untested_sequences
    missing = sequence_paths.select { |path| !File.exist? spec_file_path(path) }
    missing.map { |path| "A" + id_from_path(path) }
  end

end
