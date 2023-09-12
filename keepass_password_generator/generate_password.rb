#!/usr/bin/env ruby





# ======= #
# REQUIRE #
# ======= #

require 'optparse'




# ============= #
# SCRIPT PARAMS #
# ============= #

passwordsToGenerate = 1;
passwordLengthRange = 30..30;
outputFile = nil;
extraShuffle = true;
excludeLowercase = false;
excludeUppercase = false;
excludeDigits = false;
excludeSpecial = false;

opt_parser = OptionParser.new do |opts|

	# Number of passwords to generate
	opts.on("-n [i]", "--number [i]", Integer) do |val|
		passwordsToGenerate = val || 1;
	end

	# Password size
	opts.on("-s [i,j]", "--size [i,j]", Array) do |val|
		if (val[1] == nil)
			passwordLengthRange = (val[0].to_i)..(val[0].to_i);
		else
			passwordLengthRange = (val[0].to_i)..(val[1].to_i);
		end
	end

	# Output file
	opts.on("-w [filename]", "--writeTo [filename]", String) do |val|
		outputFile = val || nil;
	end

	# High performance
	opts.on("-x", "--extra-shuffle") do |val|
		extraShuffle = val;
	end

	# Exclude lowercase characters
	opts.on("-a", "--exclude-lowercase") do |val|
		excludeLowercase = true;
	end

	# Exclude uppercase characters
	opts.on("-A", "--exclude-uppercase") do |val|
		excludeUppercase = true;
	end

	# Exclude digits
	opts.on("-0", "--exclude-digits") do |val|
		excludeDigits = true;
	end

	# Exclude special characters
	opts.on("-_", "--exclude-special") do |val|
		excludeSpecial = true;
	end

	# Print help
	opts.on("-h", "--help") do |val|
		puts opts;
		exit;
	end

end.parse!

categories = Array.new();
if (! excludeLowercase)
	categories += ('a'..'z').to_a
end
if (! excludeUppercase)
	categories += ('A'..'Z').to_a
end
if (! excludeDigits)
	categories += ('0'..'9').to_a
end
if (! excludeSpecial)
	categories += ['-', '_', '*', '+', '@', '$', '!', '?', '.', ',', ';', '&', '#', '(', ')', '[', ']', '{', '}']
end





# ====== #
# SCRIPT #
# ====== #

output = Array.new(0);

# Multiple password generation
(1..passwordsToGenerate).each do |i|

	# A bit of extra randomization never hurts
	if (extraShuffle) then categories.shuffle!() end

	# Single password generation
	currentPassword = "";
	passwordLength = rand(passwordLengthRange);	# set current password length from range
	(1..passwordLength).each do |j|
		currentPassword += categories[rand(0...categories.length)];	# add new char at the end of current password
	end
	
	# A bit of extra randomization never hurts
	if (extraShuffle)
		currentPassword = currentPassword.split("").shuffle.join();
	end

	output.push(currentPassword);	# add current password to the list
end

# output the passwords list
if (outputFile != nil) # file
	File.open(outputFile, 'w') do |file|
		output.each do |password|
			puts(password);
			file.puts(password);
		end
	end
else	# standard output
	output.each { |password| puts(password) };
end
