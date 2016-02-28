require_relative '../b_file_compare'

PENDING_SEQUENCES ||= {
  "A268978" => "Draft (2016/02/16).",
  "A269045" => "Draft (2016/02/22).",
  "A269267" => "Draft (2016/02/24).",
  "A269331" => "Draft (2016/02/23).",
  "A269423" => "Draft (2016/02/26).",
  "A269427" => "Draft (2016/02/26).",
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
