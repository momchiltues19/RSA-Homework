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
		while true
			@e = random_prime
			if(@e < carm_n && carm_n % @e != 0)
				break			
			end		
		end
		@d = create_d(e, carm_n)
		return n, e, d
	end

	def encrypt message
		encrypted = Array.new
		message.bytes.each do |symbol|
			symbol = (symbol**@e)% @n
			encrypted.push(symbol)
		end
		encrypted 
	end

	def decrypt message 
		decrypted = String.new
		message = message.map {|char| char.to_i}
		message.each do |symbol|
			symbol = ((symbol**@d) % @n )			
			decrypted << symbol.chr
		end
		decrypted
	end

end

test = RSA.new(0,0,0)
test.new_key
puts test.decrypt(test.encrypt("abcdefg"))
