# If the numbers 1 to 5 are written out in words: one, two, three, four, 
# five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive were written out 
# in words, how many letters would be used?

# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and 
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
# letters. The use of "and" when writing out numbers is in compliance with 
# British usage.

start = Time.now

def ones_name(n)
	a = [
		"", 
		"one", 
		"two", 
		"three", 
		"four", 
		"five", 
		"six", 
		"seven", 
		"eight", 
		"nine"
	]
	a[n]
end

def tens_name(n)
	return ones_name(n) if n < 10
	b = {
	10 => 'ten',
	11 => 'eleven',
	12 => 'twelve',
	13 => 'thirteen',
	14 => 'fourteen',
	15 => 'fifteen',
	16 => 'sixteen',
	17 => 'seventeen',
	18 => 'eighteen',
	19 => 'nineteen'
	}
	return b[n] if n < 20
	c = {
	20 => 'twenty',
	30 => 'thirty',
	40 => 'forty',
	50 => 'fifty',
	60 => 'sixty',
	70 => 'seventy',
	80 => 'eighty',
	90 => 'ninety'
	}
	c[n/10 * 10] + ones_name(n % 10)
end

def hundreds_name(n)
	return "onethousand" if n == 1000
	hundreds_place = ones_name(n/100) + "hundred" unless ones_name(n/100) == ""
	hundreds_place ||= ""
	hundreds_place += "and" unless n%100 == 0 || n < 100
	hundreds_place + tens_name(n % 100)
end

x = (1..1000).collect do |i|
	hundreds_name(i)
end

p x.join.length
p Time.now - start

# 0.008281 seconds