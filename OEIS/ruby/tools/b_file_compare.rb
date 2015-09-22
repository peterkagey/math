require_relative 'helpers/b_file_cache'
require_relative 'helpers/local_b_file'
require_relative 'helpers/official_b_file'
require_relative 'helpers/cached_b_file'

class BFileCompare

  PENDING_SEQUENCES ||= {
    "A000000" => "Awaiting naming and upload.",

    "A053797" => "Awaiting upload.",
    "A072905" => "Awaiting upload.",
    "A098164" => "Awaiting upload.",
    "A121341" => "Awaiting upload.",
    "A143051" => "Awaiting upload.",
    "A163325" => "Awaiting upload.",
    "A173902" => "Awaiting upload.",

    "A117484" => "Awaiting approval of Robert Israel's b-file.",

    "A258448" => "Edit (2015/09/09).",
    "A262159" => "Edit (2015/09/17).",
    "A262343" => "Edit (2015/09/18).",
    "A262351" => "Edit (2015/09/20).",

    "A143480" => "Draft (2015/09/03).",
    "A143481" => "Draft (2015/09/03).",
    "A143483" => "Draft (2015/09/03).",
    "A259439" => "Draft (2015/09/03).",
    "A261863" => "Draft (2015/09/04).",
    "A262036" => "Draft (2015/09/08).",
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
