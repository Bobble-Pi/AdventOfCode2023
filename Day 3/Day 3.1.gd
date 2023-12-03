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

#get row length
#count from start of row to symbol
#pad the string with "." around the border to give every symbol 8 surrounding tiles
#search 8 surrounding tiles
#if there is a number search row from number untill find "."
#add to sum
#replace number with "." so there can't be duplicates
#continue search from symbol untill end of string

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
			#if the current character is a symbol
			if currentRow[x] != "." and currentRow[x] != "\n" and !currentRow[x].is_valid_int():
				
				var layers: Array = [aboveRow, currentRow, belowRow]
				
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
							#add the number to the total
							total += int(numCache)
							touched = false
							numCache = ""
						#if the current character is not a number and it was not in range
						else:
							touched = false
							numCache = ""
	
	print("Day 3 part 1: " + str(total))
