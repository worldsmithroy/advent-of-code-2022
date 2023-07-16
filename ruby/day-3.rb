PRIORITY_MAP = ('a'..'z').zip(1..26).to_h.merge(('A'..'Z').zip(27..52).to_h)

# 
def identify_duplicate (rucksack)
	middle = rucksack.length / 2
	endpoint = rucksack.length - 1
	compartment_1 = rucksack[0..middle - 1].split("")
	compartment_2 = rucksack[middle..endpoint].split("")
	compartment_1.intersection(compartment_2).first # only one item will be duplicated across each rucksack
end

def find_duplicates_in_rucksacks (data)
	data.split("\n").map{ |rucksack| identify_duplicate(rucksack) }
end

def analyze_rucksacks(data)
	find_duplicates_in_rucksacks(data).map{ |item| PRIORITY_MAP[item] }.reduce(&:+)
end

puts "Part 1:"
puts analyze_rucksacks(ARGV[0])

def find_badge (elf_group)
	elves = elf_group.split("\n").map{ |rucksack| rucksack.split("").uniq }
	elves[0].intersection(elves[1], elves[2]).first
end

def find_badges_for_elf_groups (data)
	elves = data.scan(/\w+\n\w+\n\w+/)
	elves.map{ |elf_group| find_badge(elf_group) }
end

def analyze_elves (data)
	find_badges_for_elf_groups(data).map{ |badge| PRIORITY_MAP[badge] }.reduce(&:+)
end

puts "Part 2:"
puts analyze_elves(ARGV[0])