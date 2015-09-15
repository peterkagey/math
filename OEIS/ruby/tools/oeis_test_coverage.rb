require_relative 'helpers/sequence_path_iterator'
class OEISTestCoverage

  def self.untested_sequences
    OEISTestPathIterator.untested_sequences
  end

  EXCEPTIONS = %w[]

end
