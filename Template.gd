extends Node

@export_multiline var puzzleInput: String = (
"
")


##separate a string by carriage returns
func _separateLines(inputString:String, ignoreChar: String = ""):
	var chunk: String
	var chunkArray: Array = []

	#separates the string into chunks 
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
	var total: int = 0
	
	var lines: Array = _separateLines(puzzleInput)
	
	for l in lines.size():
		print(lines[l])
	
	print("Day # part 1: " + str(total))
