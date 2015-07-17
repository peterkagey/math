require_relative '../../scripts/problems_001_009/problem001.rb'
describe ProjectEuler do

  it "should compute correctly" do
    expect(ProjectEuler.problem001).to eq 233168
  end

end
