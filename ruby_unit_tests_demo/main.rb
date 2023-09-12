class Main
	def self.hello_world
		'Hello World !'
	end

	def self.multiply(a, b)
		return nil if a.nil? || b.nil?
		a * b
	end

	def self.divide(a, b)
		return nil if a.nil? || b.nil?
		a / b.to_f
	end

	def self.fizzbuzz(i)
		return nil if i < 0

		if i % 5 == 0 && i % 3 == 0 then			
			return "JavascriptSucks"
		elsif i % 3 == 0 then
			return "Javascript"
		elsif i % 5 == 0 then
			return "Sucks"
		else
			return ""
		end
	end
end