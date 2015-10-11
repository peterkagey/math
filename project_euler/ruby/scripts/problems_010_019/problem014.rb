# inelegant solution

class ProjectEuler

	def self.f(n)
		n % 2 == 0 ? n/2 : 3 * n + 1
	end

	def self.collatz_count(n, h={1=>1})
		i = 0
		n_copy = n
		(n = f(n); i += 1) until h[n]

		h[n_copy] = i + h[n]
		h
	end

	def self.problem014
		h = {1=>1}
		(2..10**6).each { |i| h = collatz_count(i, h) }

		j = h.values.max
		h.each { |k,v| return k if v == j }
	end

end
