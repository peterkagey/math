class CachedBFile

  def initialize(b_file_compare)
    @id = b_file_compare.id
  end

  def metadata
    return @oeis_cache if @oeis_cache
    path = File.dirname(__FILE__) + "/b_file_lookup_table.json"
    @oeis_cache = JSON.parse(File.read(path))
  end

  def sequence_metadata
    metadata["A#{@id}"]
  end

  def range
    return if sequence_metadata.nil?
    "#{sequence_metadata["min"]}..#{sequence_metadata["max"]}"
  end

  def current?(b_file_update_time)
    return false if sequence_metadata.nil?
    last_updated = Time.parse(sequence_metadata["last_updated"])
    last_updated > b_file_update_time
  end

end
