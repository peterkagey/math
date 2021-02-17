class BoxDrawingCharacterFlipper

  def self.rotate_clockwise(figure)
    figure
      .split("\n")
      .map { |row| row.split("") }
      .transpose
      .map { |row| row.join("") }
      .each_slice(2).map(&:first)
      .join("\n")
      .gsub(/./,
        "─" => "│ ",
        "│" => "──",
        "┌" => "┌─",
        "┬" => "├─",
        "┤" => "┴─",
        "┴" => "┤ ",
        "├" => "┬─",
        "┐" => "└─",
        "└" => "┐ ",
        "┘" => "┘ ",
        "┼" => "┼─",
        " " => "  "
      )
  end

end

x = "
┌─┬─┬─────┐
├─┼─┤     │
├─┼─┤     │
└─┴─┴─────┘"[1..-1]

puts x
puts BoxDrawingCharacterFlipper.rotate_clockwise(x)
