require_relative '../scripts/pi'

describe 'pi functions' do
  it 'should calculate pi(n) correctly' do
    pi(2).should == 1
    pi(3).should == 2
    pi(4).should == 2
  end

  it 'should calculate pi_mask correctly' do
    expect(pi_mask(4)).to eq 0b11
  end
end
