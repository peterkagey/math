require_relative 'sandbox'

describe Sandbox do

  it "should pass" do
    expect(Sandbox.new("1012".to_i(4),"210".to_i(4), 4).xor).to eq "1222".to_i(4)
  end

  it "should pass" do
    expect(XOR.new("1012".to_i(4),"210".to_i(4), 4).xor).to eq "1222".to_i(4)
  end

end
