require_relative "../helpers/remainder_game"
require_relative "a268058"
class OEIS

# https://www.reddit.com/r/math/comments/409dfe/does_anyone_know_anything_about_this_idea_i/
  def self.a268060(n)
    a268058_cache = a268058(n)
    (1..n).find { |k| RemainderGame.length(n, k) == a268058_cache }
  end

end
