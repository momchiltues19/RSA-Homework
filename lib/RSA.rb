require "prime"

class RSA
	def initialize n, e, d
		@n = n
		@e = e
		@d = d
	end
	
	def create_d a, c_n
		for i in 2..c_n
			help_d = (i*a) % c_n
			if (help_d == 1)
				break
			end
		end
		help_d
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
		for i in rand(2..carm_n-2)..carm_n
			if(i.gcd(carm_n)==1)
				@e = i
				break
			end
		end
		@d = create_d(e, carm_n)
		return n, e, d
	end
   
	def encrypt message
  		encrypted = Array.new
  		message.bytes.each do |symbol|
			encrypted.push((symbol^@e) % @n )
  		end
  		encrypted
  	end
     
  	def decrypt message
      		decrypted = Array.new
  		message.each do |symbol|
 			decrypted.push(((symbol^@d) % @n ).chr)
  		end	
  		decrypted	
  	end 

end

test = RSA.new(0,0,0)
test.new_key
puts test.decrypt(test.encrypt("abcdefg"))

