values = File.readlines("data/data.txt")
size = values.size
values.map!(&:to_i)
values += values.map{|x| x + 1000}

puts "=== values ========================"
values.each_with_index {|e, i| puts "#{i} : #{e}"}


puts "=== ranges ========================"
ranges = Array.new(size)
size.times.each do |y|
	ranges[y] = []
	(size).times.each do |x|
		ranges[y][x] = (values[x] - values[y]) % 1000
		puts "#{values[x]} - #{values[y]} = #{(values[x] - values[y])} % 1000" 			if y == 5 && (x == 22)
	end
	puts "ranges[#{y}] = #{ranges[y]}"
end
puts

# exit

best_iterations = [99999,99999]
best_iterations_indexes = []
puts "=== find ========================"
size.times.each do |y|
	size.times.each do |x|
		puts "#{y},#{x}"								if y == 9 && x == 65
		iterations_a = ranges[y][x]
		puts "iterations_a = #{iterations_a}" 			if y == 9 && x == 65
		# iterations_b = ranges[(x+1)%100][y-1]
		iterations_b = ranges[(x+1)%100][(y-1)%100]
		puts "iterations_b = #{iterations_b}" 			if y == 9 && x == 65

		# 5, 22
		# iterations_a : 22-5 = 17
		# iterations_b = 23 -> 4 = 82

		if iterations_a > 0 && iterations_b > 0 && [iterations_a, iterations_b].max < best_iterations.max then
			best_iterations = [iterations_a, iterations_b]
			best_iterations_indexes = [y, x+1]
			# puts "#{i} : #{ranges[i]} & #{ranges[i+size/2]}   (values : #{values[i]} and #{values[i+size/2]})   (#{average < best_average ? 'new best' : ''})"
		end
	end
end
puts


puts "=== results ========================"
puts "Best range = #{best_iterations}"
puts "Best range indexes = #{best_iterations_indexes}"
puts "Matching values = #{values[best_iterations_indexes[0]]} and #{values[best_iterations_indexes[1]]}"