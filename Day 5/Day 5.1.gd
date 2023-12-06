extends Node

@export_multiline var puzzleInput: String = (
"seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
")


#seed-to-soil map:
#50 98 2
#52 50 48

#seed  soil
#0     0
#1     1
#...   ...
#48    48
#49    49
#50    52
#51    53
#...   ...
#96    98
#97    99
#98    50
#99    51

#if source <= seed <= source + range -1
	#offset = seed - source
	#seed = destination + offset

#if 50 <= 96 <= 50 + 48 -1
	#offset = 96 - 50
	#offset = 46
	#seed = 52 + offset
	#seed = 98


func _ready():
	var mapsDict: Dictionary = {}
	
	#sort data
	#separate string into the map chunks
	var mapChunks: Array = puzzleInput.split("\n\n", false)
	#the first index of maps are the seeds
	var initialSeeds: Array = mapChunks[0].split(": ", false)[1].split_floats(" ", false)
	#remove the starting seed string from the map chunks array
	mapChunks.remove_at(0)
	
	for m in mapChunks.size():
		var mapData: String = (mapChunks[m])
		mapData = mapData.split(":\n", false)[1]
		var groups: Array = mapData.split("\n", false)
		
		for i in groups.size():
			groups[i] = groups[i].split_floats(" ")
		
		mapsDict[m] = groups
	
	
	#read data
	#compare seed to conversion tables per map
	for s in initialSeeds.size():
		var seed = initialSeeds[s]
		for m in mapsDict:
			var compare: bool = true
			var currentMap: Array = mapsDict[m]
			#print("Map: " + str(m))
			for group in currentMap.size():
				var groupData: Array = currentMap[group]
				#print(groupData)
				#print(seed)
				#destination, source, range
				if groupData[1] <= seed and seed <= groupData[1] + groupData[2] -1 and compare == true:
					compare = false
					#print("Seed in range to be converted")
					var offset = seed - groupData[1]
					seed = groupData[0] + offset
	
		#set the current seed to the new seed after going through all the maps
		initialSeeds[s] = seed
	#print(initialSeeds)
	
	#get lowest number
	var lowestNum: int = initialSeeds[0]
	for i in initialSeeds.size():
		if lowestNum > initialSeeds[i]:
			lowestNum = initialSeeds[i]
	
	print("Day 5 part 1: " + str(lowestNum))
