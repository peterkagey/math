require_relative '../b_file_compare'

PENDING_SEQUENCES ||= {
  "A217489" => "Draft (2015/11/03).",
  "A082647" => "Draft (2015/12/08).",
  "A265389" => "Draft (2015/12/08)."
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
