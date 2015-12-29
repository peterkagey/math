require_relative '../helpers/sequence_path_iterator'

describe "OEIS Tests" do

  TEST_EXCEPTIONS = %w[]

  it "should test every sequence script" do
    untested = OEISTestPathIterator.untested_sequences - TEST_EXCEPTIONS
    expect(untested).to eq []
  end

end
