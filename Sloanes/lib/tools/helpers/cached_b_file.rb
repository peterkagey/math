class CachedBFile

  PATH = File.dirname(__FILE__) + "/b_file_lookup_table.json"
  METADATA = JSON.parse(File.read(PATH))

  def initialize(id)
    @id = id
  end

  def metadata
    METADATA["A#{@id}"]
  end

  def range
    return if metadata.nil?
    "#{metadata["min"]}..#{metadata["max"]}"
  end

  def current?(b_file_update_time)
    return false if metadata.nil?
    last_updated = Time.parse(metadata["last_updated"])
    last_updated > b_file_update_time
  end

end
