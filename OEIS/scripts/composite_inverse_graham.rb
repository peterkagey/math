require_relative 'a067565'

counter = 1
(1..5000).each do |i|
  v = a067565(i)
  if v != 0
    puts "#{counter} #{v}"
    counter += 1
  end
end
