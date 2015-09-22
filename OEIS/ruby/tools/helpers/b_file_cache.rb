require 'json'

class BFileCache

  PATH = File.dirname(__FILE__) + "/b_file_lookup_table.json"

  def self.new_term(id)
    file_compare = BFileCompare.new(id)
    oeis_range = file_compare.oeis_range
    local_range = file_compare.local_range
    if oeis_range != local_range
      raise "OEIS does not match local! #{oeis_range} != #{local_range}"
    end

    min, max = oeis_range.split("..")
    {
      "A#{id}" =>
      {
        "last_updated" => Time.now,
        "min" => min,
        "max" => max
      }
    }
  end

  def self.add_term(id)
    puts "Adding sequence A#{id} to cache."
    old_hash = JSON.parse(File.read(PATH))
    updated_hash = old_hash.merge new_term(id)
    File.write(PATH, updated_hash.to_json)
  end

end
