require_relative '../oeis_test_coverage'

describe "OEIS Tests" do

  it "should test every sequence script" do
    untested = OEISTestCoverage.untested_sequences - OEISTestCoverage::EXCEPTIONS
    expect(untested).to eq []
  end

end
