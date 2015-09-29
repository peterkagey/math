require_relative 'helpers/b_file_cache'
require_relative 'helpers/local_b_file'
require_relative 'helpers/official_b_file'
require_relative 'helpers/cached_b_file'

class BFileCompare

  PENDING_SEQUENCES ||= {
    "A258448" => "Edit (2015/09/09).",
    "A262159" => "Edit (2015/09/17).",
    "A262343" => "Edit (2015/09/18).",

    "A049581" => "Draft (2015/09/29).",
    "A051125" => "Draft (2015/09/29).",
    "A053797" => "Draft (2015/09/22).",
    "A259439" => "Draft (2015/09/03).",
  }

  attr_reader :local_range, :official_range, :cached_range, :id

  def initialize(sequence_id)
    @id = sequence_id
    set_b_file_classes
    set_ranges
    update_cache if cache_should_be_updated?
  end

  def skip?
    @local_b_file.missing?
  end

  def pending?
    !!pending_reason
  end

  def pending_reason
    PENDING_SEQUENCES["A#{id}"]
  end

  private

  def set_b_file_classes
    @cached_b_file   = CachedBFile.new(self)
    @local_b_file    = LocalBFile.new(self)
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
