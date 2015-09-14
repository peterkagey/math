class OEISAnalyzer

  OEISSequence = Struct.new(:name, :sequence_string) {
    def sequence
      sequence_string.split(",").map(&:to_i)
    end

    def to_s
      "#{name}: #{truncated_sequence}"
    end
    alias :inspect :to_s

    private

    def truncated_sequence(length = 50)
      seq = sequence_string[0..length][/.+,*/][0...-1]
      seq + (" " * (length - seq.length)) + "..."
    end
  }

  SEQUENCE_FORMAT = /(^A\d{6}) ,(.*)$/

  def initialize(path)
    @text = File.read(path)
    @sequence_strings = @text.split("\n")
  end

  def extract_name_and_sequence(row)
    og, name, vals = row.match(SEQUENCE_FORMAT).to_a
    seq_str = vals
    OEISSequence.new(name, seq_str)
  end

  def find_sequence(sequence_name)
    row = @sequence_strings.find { |str| str =~ /^#{sequence_name} ,/}
    return [] if row.nil?
    extract_name_and_sequence(row)
  end

  def each_sequence
    @sequence_strings.each do |row|
      yield extract_name_and_sequence(row)
    end
  end

end

class SequenceAnalyzer

  def initialize(oeis_sequence)
    @sequence = oeis_sequence.sequence
  end

  def monotonic_increasing?
    max = @sequence.length - 1
    (0...max).each { |i| return false if @sequence[i] > @sequence[i + 1] }
    true
  end

  def monotonic_decreasing?
    max = @sequence.length - 1
    (0...max).each { |i| return false if @sequence[i] < @sequence[i + 1] }
    true
  end

  def monotonic?
    monotonic_increasing? || monotonic_decreasing?
  end

  def injection?
    @sequence.uniq == @sequence
  end

  def small_terms?
    @sequence.max < 10000
  end

end

path = File.dirname(__FILE__) + "/OEIS_sequences.txt"
sequences = OEISAnalyzer.new(path)

sequences.each_sequence do |oeis_seq|
  analyzer = SequenceAnalyzer.new(oeis_seq)
  p oeis_seq if !analyzer.monotonic? && analyzer.injection? && analyzer.small_terms?
end
