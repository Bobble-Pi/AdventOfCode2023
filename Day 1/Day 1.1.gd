extends Node

class_name Day1Part1

@export_multiline var puzzleInput: String = (
"1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
")

#seperate string by spaces
#traverse from front to find first number
#traverse from back to find last number
#if there is only one number in a row just use it twice
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
		# removes non int characters from the string
		var chunkString: String = str(int(chunkArray[i]))
		# concatenate the first character with the last then turn it into int
		var calibrationValue: int = int(chunkString[0] + chunkString.right(1))
		# add the chunk value to the total
		total += calibrationValue
	
	print("Day 1 part 1: " + str(total))
