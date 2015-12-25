require_relative 'helpers/b_file_cache'
require_relative 'helpers/local_b_file'
require_relative 'helpers/official_b_file'
require_relative 'helpers/cached_b_file'

class BFileCompare

  attr_reader :local_range, :official_range, :cached_range, :id

  def initialize(sequence_id)
    @id = sequence_id
    set_b_file_classes
    return if skip?
    set_ranges
    update_cache if cache_should_be_updated?
  end

  def skip?
    @local_b_file.missing?
  end

  private

  def set_b_file_classes
    @cached_b_file   = CachedBFile.new(self)
    @local_b_file    = LocalBFile.new(self.id)
    @official_b_file = OfficialBFile.new(self)
  end

  def set_ranges
    @cached_range    = @cached_b_file.range
    @local_range     = @local_b_file.range
    @official_range  = @official_b_file.range
  end

  def cache_should_be_updated?
    return false if skip? || @cached_b_file.current?(@local_b_file.last_updated)
    @official_range == @local_range
  end

  def update_cache
    BFileCache.add_term(self)
  end

end
