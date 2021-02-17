class BrickRow

  attr_reader :brick_positions

  def initialize(brick_positions)
    # E.g. [0, 2, 4, 7]
    @brick_positions = brick_positions
  end

  def relative_end_positions
    bp = brick_positions
    ([-2] + bp[0...-1]).zip(bp).map { |a, b| b - a }
  end

  def to_s
    top_row_raw = relative_end_positions.map { |d| "  " * (d - 2) + "┏━━━"}.join("") + "\n\n"
    top = top_row_raw.gsub(/━━━[^┏]/, "━━━┓").gsub("━┏", "━┳")

    bottom_row_raw = relative_end_positions.map { |d| "  " * (d - 2) + "┗━━━"}.join("") + "\n\n"
    bottom = bottom_row_raw.gsub(/━━━[^┗]/, "━━━┛").gsub("━┗", "━┻")

    top + bottom
  end

end

class BrickTowerPrinter

  def self.merge(bottom_of_top, top_of_bottom)
    positions = bottom_of_top.length # bottom_of_top should be shorter
    # positions = top_of_bottom.length
    x = (0...positions).map do |i|
      combination = "#{bottom_of_top[i]}#{top_of_bottom[i]}"
      case combination
      when / ./ then combination[-1]
      when %(┛┓) then "┫"
      when %(┗┏) then "┣"
      when /[┛┻┗]━/ then "┻"
      when /[┛┻┗]┳/ then "╋"
      when /━[┳━]/ then combination[-1]
      else
        raise "Invalid configuration! (#{combination})"
      end
    end
    x.join + top_of_bottom[bottom_of_top.length..-1]
  end

  def self.format(brick_tower)
    sections = brick_tower.brick_rows.map(&:to_s).join("").split("\n")
    mid = sections[1...-1].each_slice(2).map { |a, b| merge(a, b) }.join("\n")
    [sections.first, mid, sections.last].join("\n")
  end

end

class Array
  def each_pair; self == [] ? [] : self[1..-1].zip(self) end
end

class BrickTower

  attr_reader :brick_rows

  def initialize(brick_rows)
    # E.g. [BrickRow.new([0, 2, 4, 6]), BrickRow.new(0, 3, 5)]
    @brick_rows = brick_rows
  end

  def all_new_brick_positions
    old_brick_positions = @brick_rows.first.brick_positions

    indirect = old_brick_positions[1..-1].
      zip(old_brick_positions).
      select { |a, b| a - b == 2 }.
      map { |a, b| b + 1 }

    (old_brick_positions + indirect).sort
  end

  require '/Users/pkagey/personal/math/Sloanes/lib/scripts/helpers/subset_logic.rb'

  def valid_new_brick_configurations
    valid_config = []
    all_new_brick_positions.each_subset do |subset|
      valid_config << subset if subset.each_pair.all? { |a, b| a - b >= 2 }
    end
    valid_config.select { |ary| ary.length > 0 }
  end

  def to_s
    BrickTowerPrinter.format(self)
  end

  def with_top_row(pos_array)
    BrickTower.new([BrickRow.new(pos_array)] + @brick_rows)
  end

  def all_children
    valid_new_brick_configurations.map do |new_row|
      self.with_top_row(new_row)
    end
  end

  def print_all_children
    puts all_children.map { |x| x.all_children }
  end

end

x = BrickTower.new([BrickRow.new([0, 2, 4])])

x.valid_new_brick_configurations.each do |top_row|
  puts "-" * 50
  x.with_top_row(top_row).print_all_children
end

# BrickTower.new([                      #     ┏━━━┓
#   BrickRow.new([2]),                  #   ┏━┻━┳━┻━┓       ┏━━━┓
#   BrickRow.new([1, 3, 9]),            #   ┣━━━╋━━━╋━━━┓   ┣━━━┫
#   BrickRow.new([1, 3, 5, 9]),         # ┏━┻━┳━┻━┳━┻━┳━┻━┳━┻━┳━┻━┓
#   BrickRow.new([0, 2, 4, 6, 8, 0xA]), # ┗━━━┻━━━┻━━━┻━━━┻━━━┻━━━┛
# ])                                    #  0 1 2 3 4 5 6 7 8 9 A B
