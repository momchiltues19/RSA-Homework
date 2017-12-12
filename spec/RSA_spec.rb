require "RSA"

RSpec.describe RSA do
	describe "when trying to use getters " do
		rsa = RSA.new(1,2,3)
		it "checks if n is equal to 1" do
			expect(rsa.n).to eq 1
		end
		it "checks if e is equal to 2" do
			expect(rsa.e).to eq 2 
		end
		it "checks if d is equal to 3" do
			expect(rsa.d).to eq 3 
		end
	end
	describe "when trying to encrypt/decrypt a message "
		rsa = RSA.new(1,1,1)
		context "by using a random key, code encrypts and decrypts " do
			it "a single character" do
				rsa.new_key
				expect(rsa.decrypt(rsa.encrypt("a"))).to eq "a"
			end
			it "a word" do
				rsa.new_key
				expect(rsa.decrypt(rsa.encrypt("hello"))).to eq "hello"
			end
			it "a sentance" do
				rsa.new_key
				expect(rsa.decrypt(rsa.encrypt("Hi, how are you?"))).to eq "Hi, how are you?"
			end
		end
	end
end
