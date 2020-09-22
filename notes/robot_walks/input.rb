def a(n)
  (1..n-2).each do |gap|
    (1..n-gap-1).each do |i|
      puts "#{n} | [#{i}, #{i+gap}] | 0"
    end
  end
end
a(12)

# https://tio.run/##dVTbUuM4EH1OvkLzQEVy2mA7Ccy6onncD5jaN6@Kkm@gYDvGdiCk@HemW7JDYGtJUVIfd5@@q30bHvfN6mfbfXzkRcleeQNVBbrpRTyfPVT7VFeshef5rOz2Nav18MhM3e67gfWmgWzfQ2tAD7qJ5jMieOM9FFCChpQYZkd4kyXvBZS8ECg/yErXaa4ZKsAxDraSH30trqKtTH2NCq@PpipY4fe/wsIPN8QxqyXvl4W4iUg4IV9NVDNTsqN32srAKs0KdFXDie5F1RcO7OE4gl0xHLqG8QdOrnux75i7FkLoJk96te8SNSZadjobzL7pp2z/HgGme/Z7jrQvkEseQAC/eQiREJAoCOdj@P90B@u/RCcVMw2rKhtOKvskUktn4uUEZbJf8t88gkZ4FeTA@yRQPhaWp15rBPRJqHystRMFxpv6k7qXT3Vw9LOXa922RZPzTLjsJc@SjULGJTFmyZ2ypBYM1ZJ4z6C9@VNs4gq9CEuTS59CRTcUvZROxSXUFfppjqWvZNEc6qLTA96Lhr@g5fPU62Osq4rrtOdGbLGtd4wKY6gwR9RrJdX9cdI20Ma6eeNk88yTnf@khDXYwROZnEzLceaEIEwT0go3fCd@sGFdzu3s7OoQj8Vq9gN7RIrW5TBrp6oZ5MHvX4O9/Qy2T@JI0bCw6ldItsmJJxmBY4QZab0w5MiSla1UJBRtwb1MhnurgktDSgVWyMo15GcZ7Xjj1@KqsjEinAQQQuWHilmvWNjhPpYJL2Fw5iU8WD2eQY4tzCETakzxmR9RtaRWG@U/uHPKhYiVy4XrWB5xRITnRUuekhBaYSvXS1rCNTnnQyz7Q835G@cd8oaAUSXpNlBedNMaz74BnIc@P8RS33Dt6WXqpchzvRHewZ5w8EMhfAPdcgdjt4eYazucyDGIMQY7mGfAD8HrcQmLnJfJbaxc5w3sKA@cxQATx3SEoiUUeEgZqbE75mLUMC0qMbXe5qssz5FYEizpxaIYuxDlxZZYRJy5BuWKb5s03FsJG0xe7hX5bjvTDJwa1uIOF61cLABHDA/hVsl9@iHxqbVT6AxqdOVmj16BHUW5dGJIIvYFGqjFOEnGTU47TdLuLNMI/JC13d/zY@hc2AgmzEGBmH/0slssFoyt2DtLVhAoNv29s2B@xsNLfPWJry7x8BOP4GzzziLEbwkPv/IEE775L/@IR9/5R3z1P/rrS/z2wi/@Nuq7fmjjXKvv8Yw4bOBWofwT8TvCbVb2PyQ8XE8fCFp/JrxBz@FfI9OXjLHW8@SVe7VuefGiKzDXfVsZbM/7Qghx8eZM@L/NQqiPPw

# Python code:
# def w(n,ll,ans):
# 	global p,q
# 	from math import sin,cos,pi,atan2
# 	def y(s,e,f,a,b):
# 		x,y=f(s),f(e)
# 		g=lambda a,b,x:0<=(x-a)%2<=b-a
# 		while e-s>1e-15:
# 			m=(s+e)/2
# 			z=f(m)
# 			if x*z<=0:
# 				e,y=m,z
# 			else:
# 				s,x=m,z
# 		return (g(a,b,s)or g(a,b,e))and[s]or[]
# 	from fractions import Fraction as R
# 	s,v,d=(0,0,R(1,2)),[],1
# 	while True:
# 		for l in ll:
# 			b=s[2]+R(1,2)*d
# 			c=s+(R(2,n)*l,d,(s[0]-cos(b*pi),s[1]-sin(b*pi)),b,b-R(2,n)*l*d)
# 			if l:
# 				v.append(c)
# 				s=(c[5][0]+cos(c[7]*pi),c[5][1]+sin(c[7]*pi),(c[7]-R(1,2)*d)%R(2))
# 			d=-d
# 		if s[2]==R(1,2):
# 			break
# 	e,l=enumerate,len(v)
# 	q=lambda x:all(abs(i)<1e-7 for i in x)
# 	p=[]
# 	h=lambda i,p:any(all(q([j-k]) for j,k in zip(i,a))for a in p)
# 	def z(u):
# 		global p,q
# 		for i in u:
# 			if not h(i,p):
# 				p.append(i)
# 	if all(abs(i)<1e-6 for i in s[:2])and l>1:
# 		[z([c[:2]]) for c in v if c[3]==R(2)]
# 		x_=[t_ for n,c in e(v) for m,d in e(v) if (n-m)%l not in [0,1,l-1] and len(t_:=[(f,t) for f,g in [(c,d),(d,c)]if not q(x:=[f[5][i]-g[5][i]for i in[0,1]])and (a:=x[0])**2+(b:=x[1])**2<=4+1e-14 and(t:=sum((y((r:=[1,-1][b<0]*2/pi*atan2((1-(u:=a/(a*a+b*b)**.5)*u)**.5,u-1))-i,r+j,lambda t:(a+cos(pi*t))**2+(b+sin(pi*t))**2-1,*sorted(f[6:]))for i,j in[(1,0),(0,1)]),[]))])==2]
# 		[z([i for i in x[1] if h(i,x[0])])for x in[[[(f[5][0]+cos(i*pi),f[5][1]+sin(i*pi))for i in t]for f,t in t_]for t_ in x_]]
# 		print(len(p),sep='',end='')
# 		if len(p)!=ans:
# 			print(min((abs(i[0]-j[0])+abs(i[1]-j[1]),n,m) for n,i in e(p) for m,j in e(p) if n!=m))
# 		else:
# 			print('')
# 	else:
# 		print(0)
