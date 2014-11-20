# You are given the following information, but you may prefer to do some 
# research for yourself.

# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century 
# unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century 
# (1 Jan 1901 to 31 Dec 2000)?

require 'date'
start = Time.now
sunday_count = 0
(1901..2000).each do |year|
	(1..12).each do |month|
		sunday_count += 1 if (Date.new(year, month, 1)).wday == 0
	end
end

p sunday_count
p Time.now - start
# 171
# 0.001831 seconds