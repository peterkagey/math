require_relative '../b_file_compare'

PENDING_SEQUENCES ||= {}

SequencePathIterator.new.sequence_numbers.each do |id|

  begin
    compare = BFileCompare.new(id)
  rescue SocketError
    puts "Could not connect to internet to check official b-file for #{id}."
    next
  end

  next if compare.skip?

  describe "#{id}" do
    it "should have a b-file that matches the OEIS version." do
      pending PENDING_SEQUENCES["#{id}"] if PENDING_SEQUENCES["#{id}"] || "#{id}" =~ /9{4}\d{2}/
      expect(compare.official_range).to eq compare.local_range
    end
  end

end
