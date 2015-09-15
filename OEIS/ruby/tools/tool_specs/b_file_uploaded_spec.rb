require_relative '../b_file_uploaded'

describe "OEIS b-files" do

  SequencePathIterator.sequence_numbers.each do |id|
    compare = BFileCompare.new(id)
    next if compare.skip?

    it "A#{id}: Local b-file should match OEIS version." do
      pending "#{compare.pending_reason}" if compare.pending?
      expect(compare.oeis_range).to eq compare.local_range
    end

  end

end
