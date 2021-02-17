require_relative '../helpers/subset_logic'

class State

  def initialize(subset)
    @state = subset
  end

  def flip(n)
    State.new((0...n).to_a - @state)
  end

  def cycle(n)
    State.new(@state.map { |i| (i + 1) % n }.sort)
  end

  def state; @state end

  def self.canonical(subset, n)
    (1...n)
      .reduce([State.new(subset)]) { |accum, _| accum << accum[-1].cycle(n) }
      .flat_map { |s| [s.state, s.flip(n).state] }
      .min
  end

end

class Polygon
  def initialize(n)
    @n = n
    make_canonical_hash!
  end

  def all_states
    @all_states ||= (0...2**@n).map { |i| Subset.zero_indexed(i) }
  end

  def canonical_states
    @canonical_states ||= @canonical_hash.values.uniq.sort.select { |s| !s.empty?}
  end

  def get_canonical_state(subset)
    @canonical_hash[subset]
  end

  def move_classes
    @move_classes ||= Hash.new { [] }
    @canonical_hash.each { |k, v| @move_classes[v] += [k] }
    @move_classes
  end

  private
  def make_canonical_hash!
    @canonical_hash = {}
    all_states.each { |state| @canonical_hash[state] = State.canonical(state, @n) }
  end

end

class Graph

  def initialize(n)
    @n = n
    @polygon = Polygon.new(n)
    @past_states = [initial_state]
    @current_states = [initial_state]
  end

  def initial_state
    @initial_state ||= @polygon.canonical_states
  end

  def symmetric_difference(a, b)
    ((a | b) - (a & b)).sort
  end

  def recurse
    p "Recursing: #{@current_states.length} states of sizes #{@current_states.map(&:length)}"
    p @current_states
    p "-" * 30
    next_generation = @current_states
      .flat_map { |s| novel_states(s) }
    return "FALSE" if next_generation.empty?
    return "TRUE" if next_generation.include?([])
    @current_states = next_generation
    recurse
  end

  def novel_states(state)
    a = @polygon.move_classes.map do |canonical_representative, all_move_classes|
      apply_moves(state, all_move_classes).select { |a| !a.empty? }
    end

    novel = a.select { |s| !@past_states.include?(s) }.uniq
    @past_states += novel
    novel
  end

  def apply_moves(current_generation, moves)
    first_pass = current_generation.flat_map do |canonical_state| # A in picture
      moves
        .map { |m| @polygon.get_canonical_state(symmetric_difference(m, canonical_state)) }
    end
    first_pass.uniq.sort
  end
end

g = Graph.new(8)
# p g.apply_moves(g.initial_state, [[0, 1], [0, 2]])
# p g.initial_state
p g.recurse # .map { |s| g.novel_states(s) }
# p g.initial_state
# A000013 gives number of canonical states.

# KEY:
# A: [0]
# B: [0, 1] 
# C: [0, 1, 2]
# D: [0, 1, 2, 3]
# E: [0, 1, 2, 3, 4, 6]
# F: [0, 1, 2, 3, 5]
# G: [0, 1, 2, 3, 5, 6]
# H: [0, 1, 2, 3, 6]
# I: [0, 1, 2, 4]
# J: [0, 1, 2, 4, 5]
# K: [0, 1, 2, 4, 5, 6]
# L: [0, 1, 2, 4, 6]
# M: [0, 1, 2, 5]
# N: [0, 1, 2, 5, 6]
# O: [0, 1, 3, 4, 6]
# P: [0, 1, 3, 5]
# Q: [0, 1, 3, 6]
# R: [0, 1, 4, 5]
# S: [0, 2, 4, 6]
#
# 1 states of sizes [19]
# [[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S]]
#
# 1 states of sizes [18]
# [[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R]]
#
# 1 states of sizes [18]
# [[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, S]]
#
# 1 states of sizes [17]
# [[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q]]
#
# 1 states of sizes [18]
# [[A, B, C, D, E, F, G, H, I, J, L, M, N, O, P, Q, R, S]]
#
# 1 states of sizes [17]
# [[A, B, C, D, E, F, G, H, I, J, L, M, N, O, P, Q, R]]
#
# 1 states of sizes [17]
# [[A, B, C, D, E, F, G, H, I, J, L, M, N, O, P, Q, S]]
#
# 3 states of sizes [18, 18, 16]
# [[A, B, C, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, R, S], [A, B, C, D, E, F, G, H, I, J, L, M, N, O, P, Q]]
#
# 3 states of sizes [17, 17, 17]
# [[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, R], [A, B, C, E, F, G, H, I, J, K, L, M, N, O, P, Q, R], [A, B, C, E, F, G, H, I, J, K, L, M, N, O, P, R, S]]
#
# 1 states of sizes [16]
# [[A, B, C, E, F, G, H, I, J, K, L, M, N, O, P, R]]
#
# 1 states of sizes [16]
# [[A, B, C, E, F, G, H, I, J, K, L, M, N, O, P, S]]
#
# 1 states of sizes [15]
# [[A, B, C, E, F, G, H, I, J, K, L, M, N, O, P]]
#
# 1 states of sizes [16]
# [[A, B, C, E, F, G, H, I, J, L, M, N, O, P, R, S]]
#
# 1 states of sizes [15]
# [[A, B, C, E, F, G, H, I, J, L, M, N, O, P, R]]
#
# 3 states of sizes [18, 18, 15]
# [[A, B, C, D, F, G, H, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, J, K, L, N, O, P, Q, R, S], [A, B, C, E, F, G, H, I, J, L, M, N, O, P, S]]
#
# 5 states of sizes [17, 17, 15, 15, 14]
# [[A, B, C, D, F, G, H, I, J, K, L, M, N, O, P, Q, R], [A, B, C, D, E, F, G, H, I, J, K, L, N, O, P, Q, R], [A, B, C, E, F, G, H, I, J, L, M, N, O, P, Q], [A, B, C, D, E, F, G, H, I, J, L, M, N, O, P], [A, B, C, E, F, G, H, I, J, L, M, N, O, P]]
#
# 3 states of sizes [17, 17, 17]
# [[A, B, C, D, E, F, G, H, I, J, K, L, N, O, P, Q, S], [A, B, C, D, F, G, H, I, J, K, L, M, N, O, P, Q, S], [A, B, C, D, F, G, H, I, J, K, L, N, O, P, Q, R, S]]
#
# 3 states of sizes [16, 16, 16]
# [[A, B, C, D, E, F, G, H, I, J, K, L, N, O, P, Q], [A, B, C, D, F, G, H, I, J, K, L, M, N, O, P, Q], [A, B, C, D, F, G, H, I, J, K, L, N, O, P, Q, R]]
#
# 1 states of sizes [16]
# [[A, B, C, D, F, G, H, I, J, K, L, N, O, P, Q, S]]
#
# 1 states of sizes [15]
# [[A, B, C, D, F, G, H, I, J, K, L, N, O, P, Q]]
#
# 1 states of sizes [16]
# [[A, B, C, D, F, G, H, I, J, L, N, O, P, Q, R, S]]
#
# 1 states of sizes [15]
# [[A, B, C, D, F, G, H, I, J, L, N, O, P, Q, R]]
#
# 1 states of sizes [15]
# [[A, B, C, D, F, G, H, I, J, L, N, O, P, Q, S]]
#
# 3 states of sizes [16, 16, 14]
# [[A, B, C, F, G, H, I, J, K, L, N, O, P, Q, R, S], [A, B, C, D, F, G, H, I, J, K, L, N, O, P, R, S], [A, B, C, D, F, G, H, I, J, L, N, O, P, Q]]
#
# 3 states of sizes [15, 15, 15]
# [[A, B, C, D, F, G, H, I, J, K, L, N, O, P, R], [A, B, C, F, G, H, I, J, K, L, N, O, P, Q, R], [A, B, C, F, G, H, I, J, K, L, N, O, P, R, S]]
#
# 1 states of sizes [14]
# [[A, B, C, F, G, H, I, J, K, L, N, O, P, R]]
#
# 1 states of sizes [14]
# [[A, B, C, F, G, H, I, J, K, L, N, O, P, S]]
#
# 5 states of sizes [18, 18, 18, 18, 13]
# [[A, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, H, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, Q, R, S], [A, B, C, F, G, H, I, J, K, L, N, O, P]]
#
# 7 states of sizes [17, 17, 17, 17, 17, 17, 14]
# [[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, Q, R], [A, B, C, D, E, F, G, H, J, K, L, M, N, O, P, Q, R], [A, B, C, D, E, F, H, I, J, K, L, M, N, O, P, Q, R], [A, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R], [A, C, D, E, F, G, H, I, J, K, L, M, N, O, Q, R, S], [A, B, C, D, E, F, H, J, K, L, M, N, O, P, Q, R, S], [A, B, C, F, G, H, I, J, L, N, O, P, R, S]]
#
# 3 states of sizes [16, 16, 13]
# [[A, C, D, E, F, G, H, I, J, K, L, M, N, O, Q, R], [A, B, C, D, E, F, H, J, K, L, M, N, O, P, Q, R], [A, B, C, F, G, H, I, J, L, N, O, P, R]]
#
# 5 states of sizes [16, 16, 13, 13, 13]
# [[A, C, D, E, F, G, H, I, J, K, L, M, N, O, Q, S], [A, B, C, D, E, F, H, J, K, L, M, N, O, P, Q, S], [A, B, C, F, G, H, I, J, L, M, N, O, P], [A, B, C, E, F, G, H, I, J, L, N, O, P], [A, B, C, F, G, H, I, J, L, N, O, P, S]]
#
# 9 states of sizes [15, 15, 16, 16, 13, 16, 16, 13, 12]
# [[A, C, D, E, F, G, H, I, J, K, L, M, N, O, Q], [A, B, C, D, E, F, H, J, K, L, M, N, O, P, Q], [A, C, D, E, F, H, J, K, L, M, N, O, P, Q, R, S], [A, C, D, E, F, H, I, J, K, L, M, N, O, Q, R, S], [A, B, C, F, G, H, I, J, L, N, O, P, Q], [A, C, D, E, F, G, H, J, K, L, M, N, O, Q, R, S], [A, B, C, D, E, F, H, J, K, L, M, N, O, Q, R, S], [A, B, C, D, F, G, H, I, J, L, N, O, P], [A, B, C, F, G, H, I, J, L, N, O, P]]
#
# 11 states of sizes [16, 16, 17, 16, 15, 17, 16, 15, 15, 15, 15]
# [[A, B, C, D, E, F, H, J, L, M, N, O, P, Q, R, S], [A, C, D, E, F, G, H, I, J, L, M, N, O, Q, R, S], [A, B, C, E, F, G, H, I, J, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, J, L, M, N, O, P, R], [A, B, C, D, E, F, H, J, K, L, M, N, O, Q, R], [A, B, C, D, E, F, G, H, I, J, L, M, N, O, P, R, S], [A, B, C, E, F, G, H, I, J, L, M, N, O, P, Q, R], [A, C, D, E, F, G, H, J, K, L, M, N, O, Q, R], [A, C, D, E, F, H, I, J, K, L, M, N, O, Q, R], [A, C, D, E, F, H, J, K, L, M, N, O, P, Q, R], [A, C, D, E, F, H, J, K, L, M, N, O, Q, R, S]]
#
# 3 states of sizes [15, 15, 14]
# [[A, B, C, D, E, F, H, J, L, M, N, O, P, Q, R], [A, C, D, E, F, G, H, I, J, L, M, N, O, Q, R], [A, C, D, E, F, H, J, K, L, M, N, O, Q, R]]
#
# 3 states of sizes [15, 15, 14]
# [[A, B, C, D, E, F, H, J, L, M, N, O, P, Q, S], [A, C, D, E, F, G, H, I, J, L, M, N, O, Q, S], [A, C, D, E, F, H, J, K, L, M, N, O, Q, S]]
#
# 3 states of sizes [14, 14, 13]
# [[A, B, C, D, E, F, H, J, L, M, N, O, P, Q], [A, C, D, E, F, G, H, I, J, L, M, N, O, Q], [A, C, D, E, F, H, J, K, L, M, N, O, Q]]
#
# 1 states of sizes [14]
# [[A, C, D, E, F, H, J, L, M, N, O, Q, R, S]]
#
# 1 states of sizes [13]
# [[A, C, D, E, F, H, J, L, M, N, O, Q, R]]
#
# 1 states of sizes [13]
# [[A, C, D, E, F, H, J, L, M, N, O, Q, S]]
#
# 3 states of sizes [14, 14, 12]
# [[A, C, E, F, H, J, K, L, M, N, O, Q, R, S], [A, C, D, E, F, H, J, K, L, M, N, O, R, S], [A, C, D, E, F, H, J, L, M, N, O, Q]]
#
# 3 states of sizes [13, 13, 13]
# [[A, C, D, E, F, H, J, K, L, M, N, O, R], [A, C, E, F, H, J, K, L, M, N, O, Q, R], [A, C, E, F, H, J, K, L, M, N, O, R, S]]
#
# 1 states of sizes [12]
# [[A, C, E, F, H, J, K, L, M, N, O, R]]
#
# 1 states of sizes [12]
# [[A, C, E, F, H, J, K, L, M, N, O, S]]
#
# 1 states of sizes [11]
# [[A, C, E, F, H, J, K, L, M, N, O]]
#
# 1 states of sizes [12]
# [[A, C, E, F, H, J, L, M, N, O, R, S]]
#
# 1 states of sizes [11]
# [[A, C, E, F, H, J, L, M, N, O, R]]
#
# 3 states of sizes [14, 14, 11]
# [[A, C, D, F, H, J, K, L, M, N, O, Q, R, S], [A, C, D, E, F, H, J, K, L, N, O, Q, R, S], [A, C, E, F, H, J, L, M, N, O, S]]
#
# 5 states of sizes [13, 13, 11, 11, 10]
# [[A, C, D, F, H, J, K, L, M, N, O, Q, R], [A, C, D, E, F, H, J, K, L, N, O, Q, R], [A, C, E, F, H, J, L, M, N, O, Q], [A, C, D, E, F, H, J, L, M, N, O], [A, C, E, F, H, J, L, M, N, O]]
#
# 3 states of sizes [13, 13, 13]
# [[A, C, D, E, F, H, J, K, L, N, O, Q, S], [A, C, D, F, H, J, K, L, M, N, O, Q, S], [A, C, D, F, H, J, K, L, N, O, Q, R, S]]
#
# 3 states of sizes [12, 12, 12]
# [[A, C, D, E, F, H, J, K, L, N, O, Q], [A, C, D, F, H, J, K, L, M, N, O, Q], [A, C, D, F, H, J, K, L, N, O, Q, R]]
#
# 1 states of sizes [12]
# [[A, C, D, F, H, J, K, L, N, O, Q, S]]
#
# 1 states of sizes [11]
# [[A, C, D, F, H, J, K, L, N, O, Q]]
#
# 1 states of sizes [12]
# [[A, C, D, F, H, J, L, N, O, Q, R, S]]
#
# 9 states of sizes [18, 18, 18, 18, 18, 18, 18, 18, 11]
# [[B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S], [A, B, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, G, H, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, J, K, L, M, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, J, K, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, J, K, L, M, N, P, Q, R, S], [A, C, D, F, H, J, L, N, O, Q, R]]
#
# 13 states of sizes [17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 11]
# [[A, B, C, D, E, F, G, H, I, J, K, M, N, O, P, Q, R], [A, B, C, D, E, F, G, H, I, J, K, L, M, N, P, Q, R], [A, B, C, D, E, G, H, I, J, K, L, M, N, O, P, Q, R], [A, B, C, D, E, F, G, I, J, K, L, M, N, O, P, Q, R], [A, B, C, D, E, F, G, H, I, K, L, M, N, O, P, Q, R], [B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R], [A, B, C, D, E, F, G, H, I, J, K, L, M, O, P, Q, R], [A, B, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R], [B, C, D, E, F, G, H, I, J, K, M, N, O, P, Q, R, S], [A, B, D, E, F, G, H, I, J, K, L, M, N, P, Q, R, S], [A, B, C, D, E, G, I, J, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, K, L, M, O, P, Q, R, S], [A, C, D, F, H, J, L, N, O, Q, S]]
#
# 15 states of sizes [16, 16, 16, 16, 16, 16, 16, 16, 12, 16, 16, 16, 16, 12, 10]
# [[B, C, D, E, F, G, H, I, J, K, M, N, O, P, Q, R], [A, B, D, E, F, G, H, I, J, K, L, M, N, P, Q, R], [A, B, C, D, E, G, I, J, K, L, M, N, O, P, Q, R], [A, B, C, D, E, F, G, H, I, K, L, M, O, P, Q, R], [B, C, D, E, F, G, H, I, K, L, M, O, P, Q, R, S], [A, B, D, E, G, I, J, K, L, M, N, O, P, Q, R, S], [A, B, D, E, F, G, I, J, K, L, M, N, P, Q, R, S], [A, B, D, E, G, H, I, J, K, L, M, N, P, Q, R, S], [A, C, F, H, J, K, L, N, O, Q, R, S], [B, C, D, E, F, G, H, I, J, K, M, O, P, Q, R, S], [A, B, C, D, E, F, G, H, I, K, M, O, P, Q, R, S], [B, C, D, E, F, G, H, I, K, M, N, O, P, Q, R, S], [A, B, C, D, E, G, I, J, K, L, M, N, P, Q, R, S], [A, C, D, F, H, J, K, L, N, O, R, S], [A, C, D, F, H, J, L, N, O, Q]]
#
# 17 states of sizes [16, 16, 16, 16, 15, 15, 15, 15, 11, 15, 15, 15, 15, 11, 15, 15, 11]
# [[A, B, C, D, E, F, G, H, I, K, L, M, O, P, Q, S], [A, B, C, D, E, G, I, J, K, L, M, N, O, P, Q, S], [A, B, D, E, F, G, H, I, J, K, L, M, N, P, Q, S], [B, C, D, E, F, G, H, I, J, K, M, N, O, P, Q, S], [A, B, C, D, E, F, G, H, I, K, M, O, P, Q, R], [A, B, C, D, E, G, I, J, K, L, M, N, P, Q, R], [A, B, D, E, G, H, I, J, K, L, M, N, P, Q, R], [A, B, D, E, F, G, I, J, K, L, M, N, P, Q, R], [A, C, D, F, H, J, K, L, N, O, R], [B, C, D, E, F, G, H, I, K, M, N, O, P, Q, R], [B, C, D, E, F, G, H, I, K, L, M, O, P, Q, R], [B, C, D, E, F, G, H, I, J, K, M, O, P, Q, R], [A, B, D, E, G, I, J, K, L, M, N, O, P, Q, R], [A, C, F, H, J, K, L, N, O, Q, R], [B, C, D, E, F, G, H, I, K, M, O, P, Q, R, S], [A, B, D, E, G, I, J, K, L, M, N, P, Q, R, S], [A, C, F, H, J, K, L, N, O, R, S]]
#
# 7 states of sizes [15, 15, 15, 15, 14, 14, 10]
# [[A, B, C, D, E, F, G, H, I, K, L, M, O, P, Q], [A, B, C, D, E, G, I, J, K, L, M, N, O, P, Q], [A, B, D, E, F, G, H, I, J, K, L, M, N, P, Q], [B, C, D, E, F, G, H, I, J, K, M, N, O, P, Q], [B, C, D, E, F, G, H, I, K, M, O, P, Q, R], [A, B, D, E, G, I, J, K, L, M, N, P, Q, R], [A, C, F, H, J, K, L, N, O, R]]
#
# 3 states of sizes [14, 14, 10]
# [[B, C, D, E, F, G, H, I, K, M, O, P, Q, S], [A, B, D, E, G, I, J, K, L, M, N, P, Q, S], [A, C, F, H, J, K, L, N, O, S]]
#
# 7 states of sizes [13, 13, 11, 11, 11, 11, 9]
# [[B, C, D, E, F, G, H, I, K, M, O, P, Q], [A, B, D, E, G, I, J, K, L, M, N, P, Q], [A, C, F, G, H, I, J, L, N, O, P], [A, B, C, F, H, I, J, L, N, O, P], [A, B, C, F, G, H, J, L, N, O, P], [A, B, C, F, G, H, I, J, L, N, O], [A, C, F, H, J, K, L, N, O]]
#
# 5 states of sizes [14, 14, 10, 10, 10]
# [[B, C, D, E, F, G, H, I, M, O, P, Q, R, S], [A, B, D, E, G, I, J, L, M, N, P, Q, R, S], [A, C, F, G, H, I, J, L, N, O], [A, B, C, F, H, J, L, N, O, P], [A, C, F, H, J, L, N, O, R, S]]
#
# 11 states of sizes [13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 9]
# [[B, C, D, E, F, G, H, I, M, O, P, Q, R], [A, B, D, E, G, I, J, L, M, N, P, Q, R], [B, D, E, G, I, J, K, L, M, N, P, Q, R, S], [B, D, E, F, G, H, I, K, M, O, P, Q, R, S], [B, C, D, E, F, G, I, K, M, O, P, Q, R, S], [B, C, D, E, G, H, I, K, M, O, P, Q, R, S], [A, B, D, E, G, I, J, K, L, M, P, Q, R, S], [A, B, D, E, G, I, J, K, M, N, P, Q, R, S], [A, B, D, E, G, I, K, L, M, N, P, Q, R, S], [B, C, D, E, F, G, H, I, K, M, P, Q, R, S], [A, C, F, H, J, L, N, O, R]]
#
# 17 states of sizes [13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 9, 13, 13, 13, 9, 9]
# [[B, C, D, E, F, G, H, I, M, O, P, Q, S], [A, B, D, E, G, I, J, L, M, N, P, Q, S], [A, B, D, E, G, I, J, K, M, N, P, Q, R], [B, C, D, E, F, G, H, I, K, M, P, Q, R], [B, C, D, E, G, H, I, K, M, O, P, Q, R], [B, C, D, E, F, G, I, K, M, O, P, Q, R], [A, B, D, E, G, I, K, L, M, N, P, Q, R], [B, D, E, G, I, J, K, L, M, N, P, Q, R], [A, B, D, E, G, I, J, K, L, M, P, Q, R], [B, D, E, F, G, H, I, K, M, O, P, Q, R], [B, D, E, G, I, J, K, M, N, P, Q, R, S], [A, C, F, H, J, L, M, N, O], [B, D, E, F, G, H, I, K, M, P, Q, R, S], [B, C, D, E, G, I, K, M, O, P, Q, R, S], [A, B, D, E, G, I, K, L, M, P, Q, R, S], [A, C, E, F, H, J, L, N, O], [A, C, F, H, J, L, N, O, S]]
#
# 29 states of sizes [14, 14, 12, 14, 14, 12, 15, 15, 12, 15, 15, 12, 12, 12, 12, 9, 12, 9, 12, 12, 9, 12, 12, 9, 12, 12, 9, 9, 8]
# [[A, B, E, G, I, J, K, L, M, N, P, Q, R, S], [A, B, D, E, G, I, J, K, L, M, N, P, R, S], [B, C, D, E, F, G, H, I, M, O, P, Q], [B, C, E, F, G, H, I, K, M, O, P, Q, R, S], [B, C, D, E, F, G, H, I, K, M, O, P, R, S], [A, B, D, E, G, I, J, L, M, N, P, Q], [A, B, C, F, G, H, I, J, K, L, M, N, O, P, R], [A, B, C, E, F, G, H, I, J, K, L, N, O, P, S], [B, D, E, G, I, J, K, M, N, P, Q, R], [A, B, C, E, F, G, H, I, J, K, L, N, O, P, R], [A, B, C, F, G, H, I, J, K, L, M, N, O, P, S], [B, D, E, F, G, H, I, K, M, P, Q, R], [B, C, D, E, G, I, K, M, O, P, Q, R], [A, B, D, E, G, I, K, L, M, P, Q, R], [B, D, E, G, I, K, L, M, P, Q, R, S], [A, C, F, H, J, L, N, O, P], [B, D, E, G, I, K, M, O, P, Q, R, S], [A, C, F, H, I, J, L, N, O], [B, D, E, F, G, I, K, M, P, Q, R, S], [B, D, E, G, H, I, K, M, P, Q, R, S], [A, C, F, H, J, L, N, O, Q], [B, D, E, G, I, J, K, M, P, Q, R, S], [A, B, D, E, G, I, K, M, P, Q, R, S], [A, C, F, G, H, J, L, N, O], [B, D, E, G, I, K, M, N, P, Q, R, S], [B, C, D, E, G, I, K, M, P, Q, R, S], [A, B, C, F, H, J, L, N, O], [A, C, D, F, H, J, L, N, O], [A, C, F, H, J, L, N, O]]
#
# 45 states of sizes [13, 13, 13, 13, 13, 13, 14, 12, 14, 12, 12, 12, 13, 17, 13, 17, 12, 17, 13, 17, 11, 13, 17, 17, 12, 13, 12, 11, 13, 17, 17, 12, 13, 12, 13, 13, 11, 11, 13, 12, 11, 11, 11, 11, 11]
# [[A, B, D, E, G, I, J, K, L, M, N, P, R], [A, B, E, G, I, J, K, L, M, N, P, Q, R], [A, B, E, G, I, J, K, L, M, N, P, R, S], [B, C, D, E, F, G, H, I, K, M, O, P, R], [B, C, E, F, G, H, I, K, M, O, P, Q, R], [B, C, E, F, G, H, I, K, M, O, P, R, S], [A, B, C, E, F, G, H, I, J, K, L, N, O, P], [A, B, D, E, G, I, K, L, M, P, Q, S], [A, B, C, F, G, H, I, J, K, L, M, N, O, P], [B, C, D, E, G, I, K, M, O, P, Q, S], [B, D, E, F, G, H, I, K, M, P, Q, S], [B, D, E, G, I, J, K, M, N, P, Q, S], [A, C, E, F, H, I, J, K, L, N, O, P, S], [B, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S], [A, C, E, F, G, H, J, L, M, N, O, P, Q], [B, C, D, E, F, G, H, I, J, K, L, M, N, P, Q, R, S], [A, B, C, E, F, G, H, J, K, L, N, O], [A, B, D, E, F, G, H, I, J, K, M, N, O, P, Q, R, S], [A, B, C, D, E, F, H, I, J, L, M, N, O], [A, B, C, D, E, F, G, H, I, J, K, M, N, P, Q, R, S], [A, B, D, E, G, I, K, M, P, Q, R], [A, C, E, F, H, J, L, M, N, O, Q, R, S], [A, B, C, D, E, G, H, I, J, K, L, M, O, P, Q, R, S], [A, B, C, D, E, F, G, I, K, L, M, N, O, P, Q, R, S], [A, C, D, E, F, H, J, L, M, N, O, R], [A, C, F, H, I, J, K, L, M, N, O, P, S], [A, B, C, F, G, H, J, K, L, M, N, O], [B, C, D, E, G, I, K, M, P, Q, R], [A, C, D, E, F, H, J, L, M, N, O, R, S], [A, B, C, D, E, G, H, I, K, L, M, N, O, P, Q, R, S], [A, B, C, D, E, F, G, I, J, K, L, M, O, P, Q, R, S], [A, C, E, F, H, J, L, M, N, O, Q, R], [A, B, C, F, G, H, J, K, L, M, N, O, S], [A, C, F, H, I, J, K, L, M, N, O, P], [A, C, D, E, F, G, H, J, L, M, N, O, P], [A, B, C, E, F, H, I, J, L, M, N, O, Q], [B, D, E, G, H, I, K, M, P, Q, R], [B, D, E, F, G, I, K, M, P, Q, R], [A, B, C, E, F, G, H, J, K, L, N, O, S], [A, C, E, F, H, I, J, K, L, N, O, P], [B, D, E, G, I, K, M, N, P, Q, R], [B, D, E, G, I, K, L, M, P, Q, R], [B, D, E, G, I, J, K, M, P, Q, R], [B, D, E, G, I, K, M, O, P, Q, R], [B, D, E, G, I, K, M, P, Q, R, S]]
#
# 15 states of sizes [12, 12, 11, 11, 11, 11, 16, 16, 16, 16, 16, 16, 16, 16, 10]
# [[A, B, E, G, I, J, K, L, M, N, P, R], [B, C, E, F, G, H, I, K, M, O, P, R], [A, B, D, E, G, I, K, L, M, P, Q], [B, C, D, E, G, I, K, M, O, P, Q], [B, D, E, F, G, H, I, K, M, P, Q], [B, D, E, G, I, J, K, M, N, P, Q], [A, B, C, D, E, F, G, H, I, J, K, M, N, P, Q, R], [A, B, D, E, F, G, H, I, J, K, M, N, O, P, Q, R], [B, C, D, E, F, G, H, I, J, K, L, M, N, P, Q, R], [B, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R], [A, B, C, D, E, F, G, I, K, L, M, N, O, P, Q, R], [A, B, C, D, E, G, H, I, J, K, L, M, O, P, Q, R], [A, B, C, D, E, F, G, I, J, K, L, M, O, P, Q, R], [A, B, C, D, E, G, H, I, K, L, M, N, O, P, Q, R], [B, D, E, G, I, K, M, P, Q, R]]
#
# 3 states of sizes [12, 12, 10]
# [[A, B, E, G, I, J, K, L, M, N, P, S], [B, C, E, F, G, H, I, K, M, O, P, S], [B, D, E, G, I, K, M, P, Q, S]]
#
# 3 states of sizes [11, 11, 9]
# [[A, B, E, G, I, J, K, L, M, N, P], [B, C, E, F, G, H, I, K, M, O, P], [B, D, E, G, I, K, M, P, Q]]
#
# 3 states of sizes [12, 12, 10]
# [[A, B, E, G, I, J, L, M, N, P, R, S], [B, C, E, F, G, H, I, M, O, P, R, S], [B, D, E, G, I, M, P, Q, R, S]]
#
# 3 states of sizes [11, 11, 9]
# [[A, B, E, G, I, J, L, M, N, P, R], [B, C, E, F, G, H, I, M, O, P, R], [B, D, E, G, I, M, P, Q, R]]
#
# 3 states of sizes [11, 11, 9]
# [[A, B, E, G, I, J, L, M, N, P, S], [B, C, E, F, G, H, I, M, O, P, S], [B, D, E, G, I, M, P, Q, S]]
#
# 9 states of sizes [11, 11, 10, 11, 11, 10, 10, 10, 8]
# [[B, C, E, F, G, H, I, M, O, P, Q], [B, C, D, E, F, G, H, I, M, O, P], [A, B, E, G, I, J, L, M, N, P], [A, B, E, G, I, J, L, M, N, P, Q], [A, B, D, E, G, I, J, L, M, N, P], [B, C, E, F, G, H, I, M, O, P], [B, E, G, I, K, M, P, Q, R, S], [B, D, E, G, I, K, M, P, R, S], [B, D, E, G, I, M, P, Q]]
#
# 3 states of sizes [9, 9, 9]
# [[B, D, E, G, I, K, M, P, R], [B, E, G, I, K, M, P, Q, R], [B, E, G, I, K, M, P, R, S]]
#
# 1 states of sizes [8]
# [[B, E, G, I, K, M, P, R]]
#
# 1 states of sizes [8]
# [[B, E, G, I, K, M, P, S]]
#
# 1 states of sizes [7]
# [[B, E, G, I, K, M, P]]
#
# 1 states of sizes [8]
# [[B, E, G, I, M, P, R, S]]
#
# 1 states of sizes [7]
# [[B, E, G, I, M, P, R]]
#
# 3 states of sizes [10, 10, 7]
# [[B, D, G, I, K, M, P, Q, R, S], [B, D, E, G, I, K, P, Q, R, S], [B, E, G, I, M, P, S]]
#
# 5 states of sizes [9, 9, 7, 7, 6]
# [[B, D, G, I, K, M, P, Q, R], [B, D, E, G, I, K, P, Q, R], [B, E, G, I, M, P, Q], [B, D, E, G, I, M, P], [B, E, G, I, M, P]]
#
# 3 states of sizes [9, 9, 9]
# [[B, D, E, G, I, K, P, Q, S], [B, D, G, I, K, M, P, Q, S], [B, D, G, I, K, P, Q, R, S]]
#
# 3 states of sizes [8, 8, 8]
# [[B, D, E, G, I, K, P, Q], [B, D, G, I, K, M, P, Q], [B, D, G, I, K, P, Q, R]]
#
# 1 states of sizes [8]
# [[B, D, G, I, K, P, Q, S]]
#
# 1 states of sizes [7]
# [[B, D, G, I, K, P, Q]]
#
# 1 states of sizes [8]
# [[B, D, G, I, P, Q, R, S]]
#
# 1 states of sizes [7]
# [[B, D, G, I, P, Q, R]]
#
# 1 states of sizes [7]
# [[B, D, G, I, P, Q, S]]
#
# 3 states of sizes [8, 8, 6]
# [[B, G, I, K, P, Q, R, S], [B, D, G, I, K, P, R, S], [B, D, G, I, P, Q]]
#
# 3 states of sizes [7, 7, 7]
# [[B, D, G, I, K, P, R], [B, G, I, K, P, Q, R], [B, G, I, K, P, R, S]]
#
# 1 states of sizes [6]
# [[B, G, I, K, P, R]]
#
# 1 states of sizes [6]
# [[B, G, I, K, P, S]]
#
# 5 states of sizes [10, 10, 10, 10, 5]
# [[D, E, G, I, K, M, P, Q, R, S], [B, D, E, I, K, M, P, Q, R, S], [B, D, E, G, K, M, P, Q, R, S], [B, D, E, G, I, K, M, Q, R, S], [B, G, I, K, P]]
#
# 7 states of sizes [9, 9, 9, 9, 9, 9, 6]
# [[B, D, E, G, I, K, M, Q, R], [B, D, E, G, K, M, P, Q, R], [B, D, E, I, K, M, P, Q, R], [D, E, G, I, K, M, P, Q, R], [D, E, G, I, K, M, Q, R, S], [B, D, E, K, M, P, Q, R, S], [B, G, I, P, R, S]]
#
# 3 states of sizes [8, 8, 5]
# [[D, E, G, I, K, M, Q, R], [B, D, E, K, M, P, Q, R], [B, G, I, P, R]]
#
# 5 states of sizes [8, 8, 5, 5, 5]
# [[D, E, G, I, K, M, Q, S], [B, D, E, K, M, P, Q, S], [B, G, I, M, P], [B, E, G, I, P], [B, G, I, P, S]]
#
# 9 states of sizes [7, 7, 8, 8, 5, 8, 8, 5, 4]
# [[D, E, G, I, K, M, Q], [B, D, E, K, M, P, Q], [D, E, K, M, P, Q, R, S], [D, E, I, K, M, Q, R, S], [B, G, I, P, Q], [D, E, G, K, M, Q, R, S], [B, D, E, K, M, Q, R, S], [B, D, G, I, P], [B, G, I, P]]
#
# 11 states of sizes [8, 8, 9, 8, 7, 9, 8, 7, 7, 7, 7]
# [[B, D, E, M, P, Q, R, S], [D, E, G, I, M, Q, R, S], [B, E, G, I, M, P, Q, R, S], [B, D, E, G, I, M, P, R], [B, D, E, K, M, Q, R], [B, D, E, G, I, M, P, R, S], [B, E, G, I, M, P, Q, R], [D, E, G, K, M, Q, R], [D, E, I, K, M, Q, R], [D, E, K, M, P, Q, R], [D, E, K, M, Q, R, S]]
#
# 3 states of sizes [7, 7, 6]
# [[B, D, E, M, P, Q, R], [D, E, G, I, M, Q, R], [D, E, K, M, Q, R]]
#
# 3 states of sizes [7, 7, 6]
# [[B, D, E, M, P, Q, S], [D, E, G, I, M, Q, S], [D, E, K, M, Q, S]]
#
# 3 states of sizes [6, 6, 5]
# [[B, D, E, M, P, Q], [D, E, G, I, M, Q], [D, E, K, M, Q]]
#
# 1 states of sizes [6]
# [[D, E, M, Q, R, S]]
#
# 1 states of sizes [5]
# [[D, E, M, Q, R]]
#
# 1 states of sizes [5]
# [[D, E, M, Q, S]]
#
# 3 states of sizes [6, 6, 4]
# [[E, K, M, Q, R, S], [D, E, K, M, R, S], [D, E, M, Q]]
#
# 3 states of sizes [5, 5, 5]
# [[D, E, K, M, R], [E, K, M, Q, R], [E, K, M, R, S]]
#
# 1 states of sizes [4]
# [[E, K, M, R]]
#
# 1 states of sizes [4]
# [[E, K, M, S]]
#
# 1 states of sizes [3]
# [[E, K, M]]
#
# 1 states of sizes [4]
# [[E, M, R, S]]
#
# 1 states of sizes [3]
# [[E, M, R]]
#
# 3 states of sizes [6, 6, 3]
# [[D, K, M, Q, R, S], [D, E, K, Q, R, S], [E, M, S]]
#
# 5 states of sizes [5, 5, 3, 3, 2]
# [[D, K, M, Q, R], [D, E, K, Q, R], [E, M, Q], [D, E, M], [E, M]]
#
# 3 states of sizes [5, 5, 5]
# [[D, E, K, Q, S], [D, K, M, Q, S], [D, K, Q, R, S]]
#
# 3 states of sizes [4, 4, 4]
# [[D, E, K, Q], [D, K, M, Q], [D, K, Q, R]]
#
# 1 states of sizes [4]
# [[D, K, Q, S]]
#
# 1 states of sizes [3]
# [[D, K, Q]]
#
# 1 states of sizes [4]
# [[D, Q, R, S]]
#
# 9 states of sizes [7, 7, 7, 7, 7, 7, 7, 7, 3]
# [[C, F, H, J, L, N, O], [A, F, H, J, L, N, O], [A, C, F, J, L, N, O], [A, C, H, J, L, N, O], [A, C, F, H, J, L, O], [A, C, F, H, J, N, O], [A, C, F, H, L, N, O], [A, C, F, H, J, L, N], [D, Q, R]]
#
# 5 states of sizes [6, 6, 6, 6, 3]
# [[C, F, H, J, N, O], [A, F, H, J, L, N], [A, C, J, L, N, O], [A, C, F, H, L, O], [D, Q, S]]
#
# 11 states of sizes [5, 5, 5, 5, 4, 5, 5, 5, 5, 4, 2]
# [[C, F, H, L, O], [A, J, L, N, O], [A, F, J, L, N], [A, H, J, L, N], [K, Q, R, S], [C, F, H, J, O], [A, C, F, H, O], [C, F, H, N, O], [A, C, J, L, N], [D, K, R, S], [D, Q]]
#
# 5 states of sizes [3, 3, 4, 4, 3]
# [[D, K, R], [K, Q, R], [C, F, H, O], [A, J, L, N], [K, R, S]]
#
# 1 states of sizes [2]
# [[K, R]]
#
# 1 states of sizes [2]
# [[K, S]]
#
# 5 states of sizes [3, 3, 3, 3, 1]
# [[G, I, P], [B, I, P], [B, G, P], [B, G, I], [K]]
#
# 3 states of sizes [2, 2, 2]
# [[G, I], [B, P], [R, S]]
#
# 9 states of sizes [3, 3, 3, 3, 3, 3, 3, 3, 1]
# [[J, L, N], [F, H, O], [C, F, O], [C, H, O], [A, J, L], [A, J, N], [A, L, N], [C, F, H], [R]]
#
# 7 states of sizes [2, 1, 2, 2, 2, 1, 1]
# [[J, N], [M], [F, H], [C, O], [A, L], [E], [S]]
