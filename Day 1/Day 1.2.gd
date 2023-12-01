extends Node

class_name Day1Part2

@export_multiline var puzzleInput: String = (
"two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
")

var numSpelling: Dictionary = {
	"one":1,
	"two":2,
	"three":3, 
	"four":4,
	"five":5,
	"six":6,
	"seven":7,
	"eight":8,
	"nine":9,
	}

#seperate string by spaces
#convert number spellings to numbers
#find first number
#find last number
#concatenate the numbers together
#turn string to int
#add all the values together


func _ready():
	var chunk: String
	var chunkArray: Array = []
	var total: int = 0

	# seperates the string into chunks 
	for ch in puzzleInput:
		# if there is a carriage return at the current character
		if ch == "\n":
			# append the chunk to the array
			chunkArray.append(chunk)
			chunk = ""
		else:
			# keep adding the characters to the chunk
			chunk += ch
	
	# calculate the value of each chunk
	for i in chunkArray.size():
		var currentChunk: String = chunkArray[i]
		var chunkReplaced: String = ""
		
		# check if there is a number spelled at each character index
		for c in currentChunk.length():
			# if the current character is an int
			if currentChunk[c].is_valid_float():
				chunkReplaced += currentChunk[c]
			else:
				# check all the spelled numbers
				for key in numSpelling:
					# if the current number spelling is found at the same spot
					if currentChunk.find(key, c) == c:
						#add the number to the new string
						chunkReplaced += str(numSpelling[key])
		
		# concatenate the first character with the last then turn it into int
		var calibrationValue: int = int(chunkReplaced[0] + chunkReplaced.right(1))
		
		#print(calibrationValue)
		# add the chunk value to the total
		total += calibrationValue
	
	print("Day 1 part 2: " + str(total))
