# As of 2016-07-27, I have no recollection of what this was to be used for.
class DominoConfigurationCounter

  INITIAL_CONFIGURATION = [
    [false, false, false],
    [false, true,  false],
    [false, true,  false],
    [false, false, false],
  ]

  attr_reader :configuration

  def initialize
    @configuration = INITIAL_CONFIGURATION
  end

  def resize; end
  def find_all_children; end

  def all_indices_to_check
    number_of_rows = @configuration.length
    number_of_columns = @configuration.first.length

    all_indices = (0...number_of_rows).flat_map do |i|
      (0...number_of_columns).map { |j| [i, j]}
    end

    all_even_indices = all_indices.select { |ary| ary.reduce(:+).even? }

    all_even_indices.select do |coordinate_pair|
      r_i, c_i = coordinate_pair
      !@configuration[r_i][c_i]
    end

  end
end

p DominoConfigurationCounter.new.all_indices_to_check
