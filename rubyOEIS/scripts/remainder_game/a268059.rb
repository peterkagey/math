# https://www.reddit.com/r/math/comments/409dfe/does_anyone_know_anything_about_this_idea_i/

require_relative "../helpers/remainder_game"

class OEIS

  # number of k's that match for a given criteria.
  def self.a268059(n)
    seq = (1..n).map { |k| RemainderGame.length(n, k) }
    seq.count(seq.max)
  end

end
