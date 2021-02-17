class RigidMotions
  attr_reader :rotation, :horizontal_reflection
  def initialize(rotation, horizontal_reflection)
    @rotation = rotation
    @horizontal_reflection = horizontal_reflection
  end
end

class RigidMotionDictionary
  attr_reader :ordered_list, :hash, :number_of_symbols
  def initialize(hash)
    @ordered_list = hash.keys
    @hash = hash
    @number_of_symbols = @ordered_list.length
  end

  def rotate(n)
    ordered_list.index(@hash[@ordered_list[n]].rotation)
  end

  def reflect(n)
    ordered_list.index(@hash[@ordered_list[n]].horizontal_reflection)
  end
end

class Grid
  attr_reader :n, :seed
  # n X n grid
  def initialize(size, dictionary, seed)
    @n = size
    @number_of_symbols = dictionary.number_of_symbols
    @dictionary = dictionary
    @symbols = dictionary.ordered_list
    throw "Invalid seed!" unless seed >= 0 && seed < (@number_of_symbols)**(n**2)
    @seed = seed
  end

  def matrix
    @matrix ||= @seed
      .to_s(@number_of_symbols)
      .rjust(n**2, '0')
      .split("")
      .map(&:to_i)
  end

  # optimize later
  def horizontal_flip
    new_seed = matrix
      .each_slice(n)
      .flat_map(&:reverse)
      .map { |i| @dictionary.reflect(i) }
      .join
      .to_i(@number_of_symbols)

    Grid.new(n, @dictionary, new_seed)
  end

  def shift_down
    new_seed = matrix
      .each_slice(n)
      .to_a
      .rotate
      .flatten
      .join
      .to_i(@number_of_symbols)

    Grid.new(n, @dictionary, new_seed)
  end

  def shift_right
    new_seed = matrix
      .each_slice(n)
      .to_a
      .flat_map(&:rotate)
      .join
      .to_i(@number_of_symbols)

      Grid.new(n, @dictionary, new_seed)
  end

  def rotate_90
    new_seed = matrix
    .each_slice(n)
    .to_a
    .transpose
    .flat_map(&:reverse)
    .map { |i| @dictionary.rotate(i) }
    .join
    .to_i(@number_of_symbols)

    Grid.new(n, @dictionary, new_seed)
  end

  def rotations
    3.times.reduce([self]) { |accum, _| accum << accum.last.rotate_90 }
  end

  def down_shifts
    (n - 1).times
      .reduce([self]) { |accum, _| accum << accum.last.shift_down }
  end

  def right_shifts
    (n - 1).times
      .reduce([self]) { |accum, _| accum << accum.last.shift_right }
  end

  def shifts
    down_shifts.flat_map(&:right_shifts)
  end

  def reflections
    [self, horizontal_flip]
  end

  def dihedral_actions
    rotations.flat_map(&:reflections)
  end

  def torus_actions
    dihedral_actions.flat_map(&:shifts)
  end

  # optimize later!
  def to_s
    matrix
      .each_slice(n)
      .to_a
      .map { |row| row.map { |i| @symbols[i] } }
      .map(&:join)
      .join("\n")
  end

  def tile
    row_tile = to_s
      .split("\n")
      .map { |row| row * 3 }
      .join("\n")
    ([row_tile] * 3).join("\n")
  end
end

class GridEnumeration
  def initialize(n, dictionary)
    h = {}
    (0...dictionary.number_of_symbols**(n**2)).each do |seed|
      next if h[seed]
      seeds = Grid
        .new(n, dictionary, seed)
        .torus_actions
        .map(&:seed)

      seeds.each { |s| h[s] = seeds.min }
    end
    h.values.uniq.each { |s| puts Grid.new(n, dictionary, s).tile, "\n" }
    puts h.values.uniq.length
  end
end


NE = "╱"
NW = "╲"
EX = "╳"
SP = "□"

MAZE_DICTIONARY0 = RigidMotionDictionary.new(
  NE => RigidMotions.new(NW, NW),
  NW => RigidMotions.new(NE, NE)
)
# 1, 6, 84, 8548
# 1, 4, 18, 669
GridEnumeration.new(3, MAZE_DICTIONARY0)

MAZE_DICTIONARY = RigidMotionDictionary.new(
  NE => RigidMotions.new(NW, NW),
  NW => RigidMotions.new(NE, NE),
  EX => RigidMotions.new(EX, EX)
)
# grid: 2, 21, 2682,
# torus: 2, 13, 374
# GridEnumeration.new(3, MAZE_DICTIONARY)

MAZE_DICTIONARY2 = RigidMotionDictionary.new(
  NE => RigidMotions.new(NW, NW),
  NW => RigidMotions.new(NE, NE),
  EX => RigidMotions.new(EX, EX),
  SP => RigidMotions.new(SP, SP)
)
# 3, 55, 34056
# 3, 34, 4172
# GridEnumeration.new(3, MAZE_DICTIONARY2)

B = "■"
W = "□"
COLOR_DICTIONARY = RigidMotionDictionary.new(
  B => RigidMotions.new(B, B),
  W => RigidMotions.new(W, W)
)
# grid: 2, 6, 102, 8548 (A054247)
# torus: 2, 6, 26, 805 (A255016)
# GridEnumeration.new(3, COLOR_DICTIONARY)

IN = "^"
OUT = "v"
BUBBLE_DICTIONARY = RigidMotionDictionary.new(
  IN => RigidMotions.new(IN, OUT),
  OUT => RigidMotions.new(OUT, IN)
)
# grid: 1, 4, 70, 8292
# torus: 1, 4, 14, 613
# GridEnumeration.new(4, BUBBLE_DICTIONARY)

BUBBLE_DICTIONARY2 = RigidMotionDictionary.new(
  IN => RigidMotions.new(IN, OUT),
  OUT => RigidMotions.new(OUT, IN),
  SP => RigidMotions.new(SP, SP)
)
# 2, 15, 2511
# 2, 13, 319
# GridEnumeration.new(1, BUBBLE_DICTIONARY2)


V = "─"
H = "│"
HV = "┼"
HORIZONTAL_VERTICAL_DICTIONARY = RigidMotionDictionary.new(
  V => RigidMotions.new(H, V),
  H => RigidMotions.new(V, H)
)
# grid: 1, 4, 84, 8292
# torus: 1, 4, 18, 733
# GridEnumeration.new(4, HORIZONTAL_VERTICAL_DICTIONARY)

HORIZONTAL_VERTICAL_DICTIONARY2 = RigidMotionDictionary.new(
  V => RigidMotions.new(H, V),
  H => RigidMotions.new(V, H),
  HV => RigidMotions.new(HV, HV)
)

# 2, 15, 2682
# 2, 15, 374
# GridEnumeration.new(3, HORIZONTAL_VERTICAL_DICTIONARY2)

UR = "╗" # "╮"
UL = "╔" # ╭
LR = "╝" # "╯"
LL = "╚" # "╰"
ANGLE_DICTIONARY = RigidMotionDictionary.new(
  UR => RigidMotions.new(LR, UL),
  UL => RigidMotions.new(UR, UR),
  LR => RigidMotions.new(LL, LL),
  LL => RigidMotions.new(UL, LR)
)
# grid: 1, 43, 32896
# torus: 1, 17, 3692
# GridEnumeration.new(3, ANGLE_DICTIONARY)

T = "╬"
D = "╩"
L = "╠"
R = "╣"
U = "╦"

# Enumerate these with no "dead ends" on the torus
# ╗╚╗╚╗╚
# ╚╗╚╗╚╗
# ╗╚╗╚╗╚
# ╚╗╚╗╚╗
# ╗╚╗╚╗╚
# ╚╗╚╗╚╗
#
# ╗╚╗╚╗╚
# ╩╦╩╦╩╦
# ╗╚╗╚╗╚
# ╩╦╩╦╩╦
# ╗╚╗╚╗╚
# ╩╦╩╦╩╦

# ╗╠╗╠╗╠
# ╚╣╚╣╚╣
# ╗╠╗╠╗╠
# ╚╣╚╣╚╣
# ╗╠╗╠╗╠
# ╚╣╚╣╚╣

# ╗╠╗╠╗╠
# ╝╠╝╠╝╠
# ╗╠╗╠╗╠
# ╝╠╝╠╝╠
# ╗╠╗╠╗╠
# ╝╠╝╠╝╠
ANGLE_DICTIONARY2 = RigidMotionDictionary.new(
  UR => RigidMotions.new(LR, UL),
  UL => RigidMotions.new(UR, UR),
  LR => RigidMotions.new(LL, LL),
  LL => RigidMotions.new(UL, LR),


  R => RigidMotions.new(D, L),
  D => RigidMotions.new(L, D),
  L => RigidMotions.new(U, R),
  U => RigidMotions.new(R, U),
  T => RigidMotions.new(T, T),
)
# GridEnumeration.new(2, ANGLE_DICTIONARY2)
