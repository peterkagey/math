require_relative 'inverse_graham_hash'

counter = 1
(1..5000).each do |i|
  v = InverseGraham::HASH[i]
  if v != 0
    puts "#{counter} #{v}"
    counter += 1
  end
end