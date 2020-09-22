require_relative 'sequence_path_iterator'

class HaskellComparer

  def self.haskell_scripts
    haskell_files = SequencePathIterator.new(:haskell).sequence_numbers
  end

  def self.ruby_scripts
    ruby_files = SequencePathIterator.new.sequence_numbers
  end

end
