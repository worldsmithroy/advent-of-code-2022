# Returns whether or not a given set of assignments fully overlap one or the other
def fully_overlaps? (assignment)
	range_a = parse_range(assignment[0])
	range_b = parse_range(assignment[1])
	range_a.cover?(range_b) || range_b.cover?(range_a)
end

# Converts a text range into a Ruby Range
def parse_range (raw_range)
	range = raw_range.split("-")
	(range.first..range.last)
end

# Returns the list of assignments where one fully overlaps the other
def overlaps (data)
	data.select{ |assignment| fully_overlaps?(assignment) }
end

# Converts a raw string of input data into a set of pairs
def parse_data (raw_data)
	raw_data.split("\n").map{ |assignment| assignment.split(",") }
end

# Returns a count of all of the assignments that fully overlap one or the other
def count_full_overlaps(raw_data)
	data = parse_data(raw_data)
	overlaps(data).count
end


puts "Part A:"
puts count_full_overlaps(ARGV[0])
puts parse_data(ARGV[0]).count