

# Calculates the total calories in an elf's pack
def calories (elf)
	elf.split("\n").map(&:to_i).reduce(&:+)
end

# Returns the calories for each member of the team
def calories_for_team (data)
	data.split("\n\n").map{ |elf| calories(elf) }.sort.reverse
end

# Calculates the elf with the most snacks
def elf_with_the_most (data)
	calories_for_team(data).max
end

# Calculates the total of the top 3 elves
def top_3_calories (data)
	calories_for_team(data)[0..2].reduce(&:+)
end

puts "Answer Part 1:"
puts elf_with_the_most(ARGV[0])
puts "\n\n"
puts "Answer Part 2:"
puts top_3_calories(ARGV[0])