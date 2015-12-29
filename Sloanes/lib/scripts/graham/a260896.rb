class OEISHelper
  def range(l, base)
    base = base.to_f
    min = 2 * l**2
    max = 2 * (l + 1)**2

    c_1 = (min/base**2 + 1).floor
    c_2 = (max/base**2 - 1).ceil
    [c_1, c_2]
  end

  # all_coefficient_ranges(l) returns an array of ranges such that the nth
  # element is the range of coefficients k such that k * n^2 is between 2*l^2
  # and 2*(l+1)^2
  def all_coefficient_ranges(l)
    base = 1
    range = range(l, base)
    all_coefficients = []
    until range[1] == 0
      all_coefficients << (range[0]..range[1])
      base += 1
      range = range(l, base)
    end
    all_coefficients.uniq
  end

  def overlap(range_1, range_2)
    mins = [range_1.min, range_2.min]
    maxes = [range_1.max, range_2.max]
    return [] if (mins + maxes).include?(nil)

    smallest_max = maxes.min
    largest_min = mins.max

    (largest_min..smallest_max).to_a
  end
end

class Array
  def each_pair
    power_ary = []
    (0...length).each do |i_0|
      (i_0...length).each { |i_1| yield(self[i_0], self[i_1]) }
    end
  end
end

def half(range)
  ((range.min/2.0).ceil .. range.max / 2)
end

class OEIS

  def self.helper
    @helper ||= OEISHelper.new
  end

  def self.a260896(n)
    coefficients_ary = []
    coefficient_ranges = helper.all_coefficient_ranges(n)
    coefficient_ranges.each_pair do |i, j|
      coefficients_ary += helper.overlap(half(i), j) unless i.max.nil?
    end

    coefficients_ary.uniq.sort.length
  end
end
