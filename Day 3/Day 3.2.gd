extends Node

@export_multiline var puzzleInput: String = (
"467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
")

# 467..114.. (114 is not next to any symbol)
# ...*......
# ..35..633.
# ......#...
# 617*......
# .....+.58. (58 is not next to any symbol)
# ..592.....
# ......755.
# ...$.*....
# .664.598.* (added * to test edge case)


#seperate each row
#find the *
#get the numbers touching it
#if there are exactly 2 numbers touching multiply them
#add to sum

##seperate a string by carriage returns
func _seperateLines(inputString:String, ignoreChar: String = ""):
	var chunk: String
	var chunkArray: Array = []

	#seperates the string into chunks 
	for ch in inputString:
		#if there is a carriage return at the current character
		if ch == "\n":
			#append the chunk to the array
			chunkArray.append(chunk)
			chunk = ""
		#ignore character provided
		elif ch != ignoreChar:
			#keep adding the characters to the chunk
			chunk += ch
	
	return chunkArray


func _ready():
	
	var rows: Array = _seperateLines(puzzleInput)
	var total: int = 0
	
	#cycle through every row
	for i in rows.size():
		
		var currentRow: String = "." + rows[i] + "."
		var blankRow: String = ""
		
		#create a blank row template
		for x in currentRow.length():
			blankRow += "."
		
		var aboveRow: String = blankRow
		var belowRow: String = blankRow
		
		#sets the rows above and below if they exist
		#prevents index out of range
		if i != 0:
			aboveRow = "." + rows[i-1] + "."
		if i != rows.size() -1:
			belowRow = "." + rows[i+1] + "."
		
		#traverse row
		for x in currentRow.length():
			#if the current character is a *
			if currentRow[x] == "*":
				
				var layers: Array = [aboveRow, currentRow, belowRow]
				var gearNumbers: Array = []
				
				#check each of the three layers
				for l in layers.size():
					#get current layer
					var currentLayer: String = layers[l]
					var touched: bool = false
					var numCache: String = ""
					
					#cycle through the tiles in the current layer
					for t in currentLayer.length():
						# if current character is a number
						if currentLayer[t].is_valid_int():
							#add number to cache
							numCache += currentLayer[t]
							#if the current tile index is in range of the symbol
							if t == x-1 or t == x or t == x+1:
								touched = true
						#if current character is not a number but it was in range
						elif numCache != "" and touched == true:
							touched = false
							#append the number to the array
							gearNumbers.append(int(numCache))
							numCache = ""
						#if the current character is not a number and it was not in range
						else:
							touched = false
							numCache = ""
				
				#if there are exactly two numbers touching the gear
				if gearNumbers.size() == 2:
					#multiply them together to get the gear ratio then add them to the total
					total += gearNumbers[0] * gearNumbers[1]
				else:
					#cycle through the array and add them to the total
					for y in gearNumbers.size()-1:
						total += gearNumbers[y]
				
	print("Day 3 part 2: " + str(total))
