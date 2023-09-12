require "test/unit"
require_relative './main'

class HelloTest < Test::Unit::TestCase

	def test_hello_world()
    	assert_equal('Hello World !', Main.hello_world, "Should return a string == 'Hello World !'")
  	end

  	def test_flunk()
	    flunk("Test was forced to fail")
  	end

  	def test_multiply()
		assert_equal(6, Main.multiply(2, 3), "Should return 6")
		assert_equal(-12, Main.multiply(-4, 3), "Should return -12")
		assert_nil(Main.multiply(2, nil), "Should return nil")
		assert_nil(Main.multiply(nil, nil), "Should return nil")
		assert_in_delta(8.96, Main.multiply(3.2, 2.8), 0.001)
  	end

  	def test_divide()
		assert_equal(2.5, Main.divide(5, 2), "Should return 2.5")
		assert_equal(-10, Main.divide(-30, 3), "Should return -10")
		assert_equal(0, Main.divide(0, 5), "Should return 0")
		assert_nothing_thrown("An Exception was raised") do
			Main.divide(5, 0)
		end
	end

  	def test_fizzbuzz()
		assert_equal("Javascript", Main.fizzbuzz(3))
		assert_equal("Sucks", Main.fizzbuzz(5))
		assert_equal("JavascriptSucks", Main.fizzbuzz(15))
		assert_equal("", Main.fizzbuzz(1))

		100.times.each do
			random_number = rand(100..10000)
			ret = Main.fizzbuzz(random_number)
			assert_match(/^(Javascript)?(Sucks)?$/, ret)
			assert_instance_of(String, ret)
		end

		assert_send( # ["Fizz", "Buzz", "FizzBuzz", ""].include?(Main.fizzbuzz(3))
			[
				["Javascript", "Sucks", "JavascriptSucks", ""],
				:include?,
				Main.fizzbuzz(3)
			],
			"Return value should be in ['Javascript', 'Sucks', 'JavascriptSucks', '']"
		)

		assert_block("Passes if the Block returns true") do
			Main.fizzbuzz(6).is_a?(String)
		end

		assert_equal(
			"Ruby",
			Main.fizzbuzz(2025),
			build_message("Worst Programming Language of the Year", "2025 -> ?", Main.fizzbuzz(2025))
		)
  	end

end