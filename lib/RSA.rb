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
		for i in rand(50..1000)...1009
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
		@e = calc_e(carm_n)
		@d = create_d(e, carm_n)
		return n, e, d
	end
   	
	def calc_e c_n
		while true
			num = rand(20..20202).to_i
			if Prime.prime?(num) && coprime(num, c_n)
				break			
			end
		end
		num
	end

	def coprime a, b 
		if a.gcd(b) == 1 then true
		else false end	
	end

	def encrypt message
  		encrypted = []
  		message.bytes.each do |symbol|
			encrypted << (symbol ** @e) % @n
  		end
  		encrypted
  	end
     
  	def decrypt message
      	decrypted = []
  		message.each do |symbol|
 			decrypted << (symbol ** @d) % @n 
  		end	
  		decrypted.map {|let| let.chr}.join	
  	end 

end

test = RSA.new(0,0,0)
test.new_key
puts test.decrypt(test.encrypt("abcdefg"))

