require_relative "../helpers/remainder_game"
require_relative "../helpers/table"

class OEIS
  # https://www.reddit.com/r/math/comments/409dfe/does_anyone_know_anything_about_this_idea_i/
  # Similar to A107435
  def self.a268057(i)
    raise "A268057 is not defined for n = #{i}" if i < 1
    n, k = OEISTable.n_k(i - 1)
    RemainderGame.length(n + k + 1, k + 1)
  end

end
