# Score for the rock, paper, scissors throws
PLAY_SCORE = {
	"rock"		=> 1,
	"paper"		=> 2,
	"scissors"	=> 3,
}

ROUND_SCORE = {
	"lose"	=> 0,
	"tie"	=> 3,
	"win"	=> 6,
}

BEATS = {
	"rock"		=> "scissors",
	"scissors"	=> "paper",
	"paper"		=> "rock",
}

PARSE_PLAY_GUIDE = {
	"A" => "rock",
	"B" => "paper",
	"C" => "scissors",
	"X" => "rock",
	"Y" => "paper",
	"Z" => "scissors",
}

PARSE_STRATEGY_GUIDE = {
	"X" => "lose",
	"Y" => "tie",
	"Z" => "win",
}

# Score a round of gameplay
def score_round (round)
	round = parse_round(round)
	score = ROUND_SCORE["tie"] # We get 3 points with a tie
	if BEATS[round["you"]] == round["them"]
		score = ROUND_SCORE["win"]
	elsif BEATS[round["them"]] == round["you"]
		score = ROUND_SCORE["lose"]
	end

	score + PLAY_SCORE[round["you"]]
end

# Convert a line of strategy into a pair of actions
def parse_round (line)
	coded_plays = line.split(" ")
	{
		"them"	=> PARSE_PLAY_GUIDE[coded_plays[0]],
		"you"	=> PARSE_PLAY_GUIDE[coded_plays[1]],
	}
end

# Score Strategy
def score_strategy (data)
	data.split("\n").map{ |round| score_round(round) }.reduce(&:+)
end

puts "Part 1:"
puts score_strategy(ARGV[0])

# Revised Strategy Parsing
def parse_round_strategically (line)
	coded_plays = line.split(" ")
	{
		"them"	=> PARSE_PLAY_GUIDE[coded_plays[0]],
		"goal"	=> PARSE_STRATEGY_GUIDE[coded_plays[1]],
	}
end

# Revised scoring strategy
def revised_score_round (round)
	round = parse_round_strategically(round)
	if round["goal"] == "tie"
		play = round["them"]
	elsif round["goal"] == "win"
		play = BEATS.key(round["them"])
	else
		play = BEATS[round["them"]]
	end

	PLAY_SCORE[play] + ROUND_SCORE[round["goal"]]
end

# Score Strategy
def score_revised_strategy (data)
	data.split("\n").map{ |round| revised_score_round(round) }.reduce(&:+)
end

puts "Part 2:"
puts score_revised_strategy(ARGV[0])