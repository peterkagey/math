# brick_stack = [
#   [4],
#   [1, 3, 5, 8],
#   [0, 2, 5, 7],
#   [1, 6],
#   [1, 3, 5, 7]
# ]
#         ┏━━━┓
#   ┏━━━┳━┻━┳━┻━┓ ┏━━━┓
# ┏━┻━┳━┛━┳━╋━━━╋━┻━┳━┛
# ┗━┳━┻━┳━┛ ┗━┳━┻━┳━┛
#   ┣━━━╋━━━┳━┻━┳━┻━┓
#   ┗━━━┻━━━┻━━━┻━━━┛
#  0 1 2 3 4 5 6 7 8 9 A B

def drop_brick(brick_stack, position)
  sublayer_index = brick_stack.each_index.find do |layer_index|
    brick_stack[layer_index].any? { |brick| (brick - position).abs <= 1 }
  end
  sublayer_index ||= brick_stack.length
  return [[position]] + brick_stack if sublayer_index == 0
  brick_stack.each_with_index.map do |layer, i|
    i + 1 == sublayer_index ? (layer + [position]).sort : layer
  end
end

def normalize(brick_stack)
  min_value = brick_stack.map { |layer| layer.min }.min
  brick_stack.map do |layer|
    layer.map { |b| b - min_value }
  end
end

def next_generation(stack)
  brick_stack = normalize(stack)
  rightmost_brick = brick_stack.map { |layer| layer.max }.max
  upper_bound = [brick_stack.last.max + 2, rightmost_brick + 1].max
  [normalize(drop_brick(brick_stack, -1))] + (0..upper_bound).map do |i|
    drop_brick(brick_stack, i)
  end
end

def generation(n)
  return [[[0]]] if n == 1
  generation(n-1).flat_map { |i| next_generation(i) }.uniq
end

p generation(8).length
