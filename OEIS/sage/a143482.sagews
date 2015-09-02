def least_multiple_of_phi_n_geq_k(n, k):
    j = 1
    while euler_phi(j * n) < k:
        j += 1
    return j * n

list = [1]
for n in xrange(2,10001):
    if n % 250 == 0:
        print n
    new_value = least_multiple_of_phi_n_geq_k(n, euler_phi(list[-1]))
    list.append(new_value)
print list
