require '/Users/pk/personal/math/Sloanes/lib/scripts/helpers/is_square.rb'

class OEIS
  # increasing length-3 sequences that sum to n
  def self.increasing_sequences(perimeter)
    (1..perimeter/3).flat_map do |shortest_side|
      (shortest_side..(perimeter - shortest_side)/2).map do |medium_side|
        [shortest_side, medium_side, perimeter - shortest_side - medium_side]
      end
    end
  end

  def self.integer_area?(perimeter, a, b, c)
    s = perimeter/2 # semiperimeter
    (s * (s-a) * (s-b) * (s-c)).is_square?
  end

  def self.heronian_triangles(perimeter)
    return [] if perimeter.odd?
    increasing_sequences(perimeter)
      .select { |a, b, c| a + b > c && integer_area?(perimeter, a, b, c) }
      .select { |sides| sides.reduce(&:gcd) == 1 }
      .select { |sides| sides.uniq.length == 2 }
  end

  def self.number_of_heronian_triangles(perimeter)
    heronian_triangles(perimeter).length
  end

end

p (1..Float::INFINITY).each { |i| ts = OEIS.heronian_triangles(2 * i); p 2*i, ts if ts.length > 0 }
