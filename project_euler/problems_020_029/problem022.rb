# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
# containing over five-thousand first names, begin by sorting it into
# alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a
# name score.

# For example, when the list is sorted into alphabetical order, COLIN, which
# is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
# would obtain a score of 938 × 53 = 49714.

# What is the total of all the name scores in the file?

start = Time.now
file = File.open("accessory_p022.txt", "rb").read
file = file.gsub(/\"/, "").split(",").sort
h = {}
('A'..'Z').to_a.each_with_index{|l,i| h[l] = i+1}

def letter_sum(string, h=nil)
	h ||= {}
	('A'..'Z').to_a.each_with_index{|l,i| h[l] = i+1} if h.length == 0
	string.split("").collect{|x| h[x]}.reduce(:+)
end

name_sum = 0
file.each_with_index do |name, index|
	name_sum += letter_sum(name) * (index+1)
end

p name_sum
p Time.now - start

# 871198282
# 0.149195 seconds