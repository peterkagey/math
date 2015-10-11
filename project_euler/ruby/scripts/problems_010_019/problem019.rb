class ProjectEuler

  def self.problem019
    months = (1901..2000).flat_map do |y|
      (1..12).map { |m| [m, y] }
    end

    months.select { |month, year| Time.new(year, month, 1).wday == 0 }.length
  end
end
