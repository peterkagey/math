def sieve_of_eratosthenes(n)
    threshold = Math.sqrt(n).to_i
    bool_arry = [false, false] + [true] * (n-1)

    p = 2
    loop do
        (p**2..n).step(p).each { |i| bool_arry[i] = false }
        (p+1..threshold).each { |k| p = k; break if bool_arry[p] }
        break if p >= threshold
    end
    bool_arry.each_index.select{ |i| bool_arry[i] }
end

p sieve_of_eratosthenes(8)