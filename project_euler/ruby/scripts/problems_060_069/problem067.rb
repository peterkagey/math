

file = File.open(File.dirname(__FILE__)+"/accessory_p067.txt", "rb").read
tri = file.gsub(/\"/, "").split("\n").collect!{|x| x.split(" ").map(&:to_i)}

start = Time.now

r_i = 0
tri[1..-1].each do |row|  # iterate from top to bottom
	r_i += 1; c_i = -1
	tri[r_i] = row.collect do
		c_i += 1
		tri[r_i][c_i] + [tri[r_i - 1][c_i], tri[r_i - 1][c_i - 1]].compact.max
	end
end

p tri.last.max
p Time.now - start

# 7273
# 0.00286 seconds