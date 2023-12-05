extends Node

@export_multiline var puzzleInput: String = (
"Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
")

#separate string by carriage return (creates array of cards)
#loop through each card
#split string at ": " and take second half
#split string at " | " the winning numbers are on the right and the left are the ones drawn
#separate each number on the winning and drawn sides
#loop through drawn side then compare to loop through winning
#count how many drawn match the winning numbers

#duplicate the next match number of cards
#ex:
#card 1 has 4 matches
#duplicate the next 4 cards (2, 3, 4, 5)
#card 2 has 2 matches
#duplicate the next 2 cards (3, 4)


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
	var cards: Dictionary = {}
	var total: int = 0
	
	#sort the data
	var cardStrings: Array = _separateLines(puzzleInput)
	#cycle through the card strings
	for c in cardStrings.size():
		#reset the matches per card
		var matches: int = 0
		var copies: int = 1
		
		#get current card string
		var currentCard: String = cardStrings[c]
		#remove "Card #: " from the current card string
		currentCard = currentCard.split(": ", false)[1]
		#split card into an array with the win string at 0 and drawn string at 1
		var cardSides: Array = currentCard.split(" | ", false)
		#split each side's numbers (converts them to int)
		cardSides[0] = cardSides[0].split_floats(" ", false)
		cardSides[1] = cardSides[1].split_floats(" ", false)
		
		#find how many matches are in a card
		#0 is win, 1 is drawn
		#cycle through the drawn numbers and compare them to the winning numbers
		for drawnNum in cardSides[1].size():
			#cycle through the winning numbers
			for winNum in cardSides[0].size():
				#if the current drawn number is equal to any of the win numbers
				if cardSides[1][drawnNum] == cardSides[0][winNum]:
					#increase match count for current card
					matches += 1
		
		#append card data to the dictionary
		cards[cards.size() +1] = [cardSides[0], cardSides[1], matches, copies]
	
	#read and modify the data
	#cycle through all the cards to calculate the how many copies there are
	for key in cards:
		#if the card has at least one match
		if cards[key][2] > 0:
			#cycle through the matches to get the cards under the current card
			for i in range(key +1, cards[key][2] + key +1):
				#add the copies of the current card to the copies of the cards under
				cards[i][3] = cards[key][3] + cards[i][3]
	
	#add all the copies together
	for key in cards:
		total += cards[key][3]
	
	print("Day 4 part 2: " + str(total))
