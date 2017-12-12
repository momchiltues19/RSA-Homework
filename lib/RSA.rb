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
    encrypted_array = Array.new

    message.each_char do |ch|
      ch = ch.ord #.ord -> to ascii
      encrypted_char = ch ** e % n
      encrypted_array << encrypted_char
    end

    encrypted_array = encrypted_array.to_s[1..-2]
    encrypted_array
  end

  def decrypt message
    decrypted_array = String.new
    message.split(', ').each do |num|
      decrypted_char = num.to_i ** d % n
      decrypted_array << decrypted_char.chr # .chr -> to char
    end
    decrypted_array
  end

end

test = RSA.new(0,0,0)
test.new_key
puts test.decrypt(test.encrypt("abcdefg"))

