require_relative 'sequence_path_iterator'
class LocalBFile

  def initialize(b_file_compare)
    @id = b_file_compare.id
  end

  def missing?
    !!BFilePathIterator.missing_b_files.find { |file| file =~ /#{@id}/ }
  end

  def path
    @path ||= BFilePathIterator.number_to_path(@id)
  end

  def range
    return "missing (local)" if !File.exists? path
    pairs = File.read(path).split(/\s/).each_slice(2).map(&:first)
    pairs.first + ".." + pairs.last
  end

  def last_updated
    File.mtime(path)
  end

end
