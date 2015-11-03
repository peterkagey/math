require_relative '../b_file_compare'

PENDING_SEQUENCES ||= {
  "A262343" => "Edit (2015/09/18).",
}

SequencePathIterator.sequence_numbers.each do |id|

  compare = BFileCompare.new(id)
  next if compare.skip?

  describe "A#{id}" do
    it "should have a b-file that matches the OEIS version." do
      pending PENDING_SEQUENCES["A#{id}"] if PENDING_SEQUENCES["A#{id}"]
      expect(compare.official_range).to eq compare.local_range
    end
  end

end
