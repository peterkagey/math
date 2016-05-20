PROJECT_ROOT = File.dirname(File.dirname(__FILE__))
require PROJECT_ROOT + "/tools/helpers/sequence_path_iterator"

class OEISDataBuilder
  def initialize(sequence_name, min)
    raise "Minimum term is not defined" if min.nil?
    @min = min.to_i
    @id = "a" + sequence_name[/\d+/].rjust(6, '0')
  end

  def sequence
    require SequencePathIterator.new.sequence_path(@id)
    (@min..Float::INFINITY).inject([]) do |accum, i|
      new_string = accum + [OEIS.send(@id, i)]
      return accum.join(", ") if new_string.join(", ").length > 260
      new_string
    end
  end
end

puts OEISDataBuilder.new(ARGV[0], ARGV[1]).sequence
