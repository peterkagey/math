require_relative 'helpers/b_file_cache'
require_relative 'helpers/local_b_file'
require_relative 'helpers/official_b_file'
require_relative 'helpers/cached_b_file'

class BFileCompare

  attr_reader :id

  def initialize(sequence_id)
    @id = sequence_id[/\d{6}/]
    set_b_file_classes
    return if skip?
    update_cache if cache_should_be_updated?
  end

  def skip?
    @local_b_file.missing? # Handled by b-file coverage spec.
  end

  def local_range
    @local_range ||= @local_b_file.annotated_range
  end

  def official_range
    @official_range ||= @cached_b_file.range || OfficialBFile.new(@id).range
  end

  private

  def set_b_file_classes
    @cached_b_file   = CachedBFile.new(@id)
    @local_b_file    = LocalBFile.new(@id)
  end

  def cache_should_be_updated?
    return false if skip?
    return false if @cached_b_file.current?(@local_b_file.last_updated)
    @official_range == @local_range
  end

  def update_cache
    BFileCache.add_term(self)
  end

end
