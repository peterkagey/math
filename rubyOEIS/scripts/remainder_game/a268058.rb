require_relative "../helpers/remainder_game"

class OEIS

# https://www.reddit.com/r/math/comments/409dfe/does_anyone_know_anything_about_this_idea_i/
  def self.a268058(n)
    (1..n).map { |k| RemainderGame.length(n, k) }.max
  end

end
