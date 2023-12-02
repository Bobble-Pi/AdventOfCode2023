extends Node

# break each game
# break each game into sets
# break each set into cubes
# compare the cubes with the highest recorded value per color
# get power by multipling red green and blue minimum cubes required
# add power to total

@export_multiline var puzzleInput: String = (
"Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
")


## seperate a string by carriage returns
func _seperateLines(inputString:String, ignoreChar: String = ""):
	var chunk: String
	var chunkArray: Array = []

	# seperates the string into chunks 
	for ch in inputString:
		# if there is a carriage return at the current character
		if ch == "\n":
			# append the chunk to the array
			chunkArray.append(chunk)
			chunk = ""
		# ignore character provided
		elif ch != ignoreChar:
			# keep adding the characters to the chunk
			chunk += ch
	
	return chunkArray


func _ready():
	var games: Dictionary = {}
	var total: int = 0
	
	# seperate the puzzle input into their games and remove spaces
	var lineArray: Array = _seperateLines(puzzleInput, " ")
	
	# sort the data into a dictionary
	for i in lineArray.size():
		# get the current game
		var currentGame: String = lineArray[i]
		# remove the Game ##: from the current game string
		currentGame = currentGame.split(":", false)[1]
		# seperate the sets in each game
		var currentSet: Array = currentGame.split(";", false)
		
		# array to hold the new sorted sets
		var gameSets: Array = [] # Array((r,g,b), (r,g,b))
		
		
		for x in currentSet.size():
			var currentSetString: String = currentSet[x]
			var cubes: Array = currentSetString.split(",", false)
			
			# vector 3 to hold the sorted cubes
			var setDraw: Vector3i = Vector3i(0, 0, 0) # Vector3i(red, green, blue)
			
			for y in cubes.size():
				var currentCube: String = cubes[y]
				# find the spellings of numbers then place them in a vector 3 reordered
				for z in currentCube.length():
					if currentCube.find("red", z) == z:
						setDraw[0] = int(currentCube)
					elif currentCube.find("green", z) == z:
						setDraw[1] = int(currentCube)
					elif currentCube.find("blue", z) == z:
						setDraw[2] = int(currentCube)
			# add the sets to the game
			gameSets.append(setDraw)
		# add the games to the dictionary
		games[games.size()+1] = gameSets
	
	
	# compare the data
	# get the fewest number of cubes for each color
	for key in games:
		var currentGame: Array = games[key]
		var minRed: int = 0
		var minGreen: int = 0
		var minBlue: int = 0
		
		for i in currentGame.size():
			var currentSet: Vector3i = currentGame[i]
			# if the minimum is less than the current set the minimum to current
			if minRed < currentSet[0]:
				minRed = currentSet[0]
			if minGreen < currentSet[1]:
				minGreen = currentSet[1]
			if minBlue < currentSet[2]:
				minBlue = currentSet[2]
		
		# multipliy the colors with eachother to get the power
		var power: int = minRed * minGreen * minBlue
		# add them all up
		total += power
		
	print("Day 2 part 2: " + str(total))
