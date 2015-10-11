start = Time.now

power_arry = []
(2..100).each do |a|
  (2..100).each do |b|
    power_arry << a**b
  end
end

p power_arry.uniq.length
p Time.now - start
# 9183
# 0.017521 seconds
