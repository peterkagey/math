class ProjectEuler

  def self.problem016
    (2**1000).to_s.split("").map(&:to_i).reduce(:+)
  end

end
