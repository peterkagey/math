require 'json'

class BFileCache

  PATH = File.dirname(__FILE__) + "/b_file_lookup_table.json"

  def self.new_term(file_compare)
    official_range = file_compare.official_range
    local_range = file_compare.local_range
    if official_range != local_range
      raise "OEIS does not match local! #{official_range} != #{local_range}"
    end

    min, max = official_range.split("..")
    {
      "A#{file_compare.id}" =>
      {
        "last_updated" => Time.now,
        "min" => min,
        "max" => max
      }
    }
  end

  def self.add_term(id)
    old_hash = JSON.parse(File.read(PATH))
    updated_hash = old_hash.merge new_term(id)
    File.write(PATH, JSON.pretty_generate(updated_hash))
  end

end
