require '/Users/pk/personal/math/Sloanes/lib/scripts/helpers/is_square.rb'

class OEIS
  # increasing length-3 sequences that sum to n
  def increasing_sequences(perimeter)
    (1..perimeter/3).flat_map do |shortest_side|
      (shortest_side..(perimeter - shortest_side)/2).map do |medium_side|
        [shortest_side, medium_side, perimeter - shortest_side - medium_side]
      end
    end
  end

  def integer_area?(perimeter, a, b, c)
    s = perimeter/2 # semiperimeter
    (s * (s-a) * (s-b) * (s-c)).is_square?
  end

  def heronian_triangles(perimeter)
    return [] if perimeter.odd?
    increasing_sequences(perimeter)
      .select { |a, b, c| a + b > c && integer_area?(perimeter, a, b, c) }
  end

  def number_of_heronian_triangles(perimeter)
    heronian_triangles(perimeter).length
  end

  # def self.a305717(n)
    # number_of_heronian_triangles(a051518(n))
  # end
end
