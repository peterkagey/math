require_relative '../b_file_compare'

PENDING_SEQUENCES ||= {
  "A107435" => "Edit  (2015/02/03).",
  "A268060" => "Edit  (2015/02/03).",
  "A268398" => "Draft (2015/02/03).",
  "A268403" => "Draft (2015/02/03).",
}

SequencePathIterator.sequence_numbers.each do |id|

  begin
    compare = BFileCompare.new(id)
  rescue SocketError
    puts "Could not connect to internet to check official b-file for A#{id}."
    next
  end

  next if compare.skip?

  describe "A#{id}" do
    it "should have a b-file that matches the OEIS version." do
      pending PENDING_SEQUENCES["A#{id}"] if PENDING_SEQUENCES["A#{id}"]
      expect(compare.official_range).to eq compare.local_range
    end
  end

end
