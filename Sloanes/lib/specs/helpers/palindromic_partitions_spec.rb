require_relative __FILE__.sub("specs", "scripts").sub("_spec", "")

# a(6)
# 0b000 | 0 ->  oooooo      = [6]
# 0b001 | 1 ->  ooo ooo     = [3, 3]
# 0b010 | 2 ->  oo oo oo    = [2, 2, 2]
# 0b011 | 3 ->  oo o o oo   = [2, 1, 1, 2]
# 0b100 | 4 ->  o oooo o    = [1, 4, 1]
# 0b101 | 5 ->  o oo oo o   = [1, 2, 2, 1]
# 0b110 | 6 ->  o o oo o o  = [1, 1, 2, 1, 1]
# 0b111 | 7 ->  o o o o o o = [1, 1, 1, 1, 1, 1]

# a(7)
# 0b000 | 0 ->    ooooooo    = [7]
# 0b001 | 1 ->   ooo o ooo   = [3, 1, 3]
# 0b010 | 2 ->   oo ooo oo   = [2, 3, 2]
# 0b011 | 3 ->  oo o o o oo  = [2, 1, 1, 1, 2]
# 0b100 | 4 ->   o ooooo o   = [1, 5, 1]
# 0b101 | 5 ->  o oo o oo o  = [1, 2, 1, 2, 1]
# 0b110 | 6 ->  o o ooo o o  = [1, 1, 3, 1, 1]
# 0b111 | 7 -> o o o o o o o = [1, 1, 1, 1, 1, 1, 1]

describe PalindromicPartitions do

  it "should know all partitions of an even palindrome" do
    expect(PalindromicPartitions.new.part(6)).to eq [
      [3, 3],
      [2, 2, 2],
      [2, 1, 1, 2],
      [1, 4, 1],
      [1, 2, 2, 1],
      [1, 1, 2, 1, 1],
      [1, 1, 1, 1, 1, 1]
    ]
  end

  it "should know all partitions of an even palindrome" do
    expect(PalindromicPartitions.new.part(7)).to eq [
      [3, 1, 3],
      [2, 3, 2],
      [2, 1, 1, 1, 2],
      [1, 5, 1],
      [1, 2, 1, 2, 1],
      [1, 1, 3, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
    ]
  end
end
