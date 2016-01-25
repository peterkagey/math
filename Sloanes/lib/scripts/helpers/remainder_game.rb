# https://www.reddit.com/r/math/comments/409dfe/does_anyone_know_anything_about_this_idea_i/
class RemainderGame

  def self.length(n, k)
    (0..Float::INFINITY).inject do |_, i|
      k = n % k
      break i if k == 0
    end
  end

end
