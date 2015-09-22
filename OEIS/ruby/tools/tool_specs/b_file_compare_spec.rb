require_relative '../b_file_compare'


SequencePathIterator.sequence_numbers.each do |id|
  compare = BFileCompare.new(id)
  next if compare.skip?

  describe "A#{id}" do
    it "should have a b-file that matches the OEIS version." do
      pending "#{compare.pending_reason}" if compare.pending?
      expect(compare.official_range).to eq compare.local_range
    end
  end

end
