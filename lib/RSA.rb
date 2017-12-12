require "prime"

class RSA
	def initialize n, e, d
		@n = n
		@e = e
		@d = d
	end
	
	def egcd(a, b)
		if(a==0)
			return b, 0, 1
		else
			g, y, x = egcd(b % a, a )
			return g, x - (b/a) * y, y
		end
	end
	#egcd was made with the help of stack overflow
	def modinv(a, m)
		g, y, x = egcd(a, m)
		return x % m 
	end 

	def random_prime
		for i in rand(10..1000)...1009
			if(Prime.prime?(i))
				return i
			end
		end	
	end 	
	def n
		@n
	end
   
	def e
		@e
	end
   
	def d
		@d
	end
   
	def new_key
		p = random_prime
		while (true)	
			q = random_prime
			break if q == p
		end
		@n = p*q
		carm_n = (p-1).lcm(q-1)
		while(true)
			i = rand(20..carm_n)
			if(i.gcd(carm_n)==1)
				@e = i
				break
			end
		end
		@d = modinv(e, carm_n)
		return n, e, d
	end
   
	def encrypt message
		encrypted = Array.new
		message.bytes.each do |symbol|
			encrypted.push(((symbol^@e) % @n ).chr)
		end
		return encrypted
	end
   
	def decrypt message
    	decrypted = Array.new
		message.each do |symbol|
			decrypted.push((((symbol.ord)^(@e*@d)) % @n ).chr)
		end	
		return decrypted	
	end 
end

test = RSA.new(0,0,0)
test.new_key
puts test.decrypt(test.encrypt("abcdefg"))

