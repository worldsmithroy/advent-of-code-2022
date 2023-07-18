# returns whether or not a range completely contains the other
def fully_overlaps? (assignment)
	range_a = assignment[0]
	range_b = assignment[1]
	range_a.include?(range_b) or range_b.include?(range_a)
end

def to_range_pair (row_string)
	row_string.split(",").map{ |raw_range| parse_range }
end

def parse_range (raw_range)
	endpoints = raw_range.split("-")
	(endpoints.first..endpoints.last)
end

def overlaps (data)
	data.select{ |assignment| fully_overlaps?(assignment) }
end

def parse_data (raw_data)
	raw_data.split("/n").map{ |assignment| to_range_pair(assignment) }
end

def count_full_overlaps(raw_data)
	data = parse_data(raw_data)
	overlaps(data).count
end


puts "Part A:"
puts count_full_overlaps(ARGV[0])