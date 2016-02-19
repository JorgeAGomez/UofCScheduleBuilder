# http://docs.python-guide.org/en/latest/scenarios/scrape/

from lxml import html
import requests
import json
import xml.etree.ElementTree
import itertools

def extractJSON(filename):
	with open(filename) as data_file:    
		data = json.load(data_file)

	return data

def shingles(str, windowSize):
	return [str[i:i+windowSize] for i in xrange(len(str)- (windowSize - 1))]

def addShinglesToOfferings(offerings):
	for o in offerings:
		for p in o["periodics"]:
			# p["shingles"] = shingles(p["instructor"],2)
			p["shingles"] = [shingles(x,2) for x in p["instructor"]]

def addShinglesToProfs(profs):
	for p in profs:
		p["shingles"] = shingles(p["fullname"],2)

def jaccardIndex(lst1, lst2):
	set1 = set(lst1)
	set2 = set(lst2)

	intersection = set1.intersection(set2)
	union = set1.union(set2)

	return  float(len(intersection)) / float(len(union))

def matchLists(offerings,profs):
	for o in offerings:
		for p in o["periodics"]:
			matchedNames = []
			matchedIndexes = []
			for insShingles in p["shingles"]:
				matchedName = ""
				highestJIndex = 0				

				for prof in profs:
					index = jaccardIndex(insShingles, prof["shingles"])

					if index > highestJIndex:
						highestJIndex = index
						matchedName = prof["fullname"]

				if highestJIndex >= 0.45:		
					matchedNames.append(matchedName)
				else:
					matchedNames.append("None")

				matchedIndexes.append(highestJIndex)

			p["matchedNames"] = matchedNames
			# p["matchedIndexes"] = matchedIndexes

			del p["shingles"]

def saveTOJSON(offerings, filename):
	with open(filename, 'w') as outfile:
		json.dump(offerings,outfile ,indent=4)

def main():
	offerings = extractJSON("./data/courseOfferings.json")
	profs = extractJSON("./data/profs.json")

	addShinglesToOfferings(offerings)
	addShinglesToProfs(profs)

	matchLists(offerings,profs)

	saveTOJSON(offerings,"./data/courseOfferings2.json")

	# for o in offerings:
	# 	for p in o["periodics"]:
	# 		for a, b, c in itertools.izip(p["instructor"], p["matchedNames"], p["matchedIndexes"]):
	# 			if a != "Staff" and b != "None":
	# 				print a + " | " + b + " | " + str(c)


	# print json.dumps(offerings, sort_keys=True, indent=4, separators=(',', ': '))

if __name__ == '__main__':
    main()