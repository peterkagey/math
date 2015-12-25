require_relative '../b_file_coverage'

describe "OEIS Tests" do

  it "should check that all b-files are present." do
    unexpectedly_missing_b_files = BFileCoverage.missing_b_files - BFileCoverage::EXPECTED
    expect(unexpectedly_missing_b_files).to eq []
  end

end
