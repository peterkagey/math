require_relative 'a067565'

seq = (1..5000).collect { |i| OEIS.a067565(i) }.reject { |a_i| a_i == 0 }
seq.each_with_index { |a_i, index| puts "#{index + 1} #{a_i}"}