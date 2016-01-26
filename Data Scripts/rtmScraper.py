# http://docs.python-guide.org/en/latest/scenarios/scrape/

from lxml import html
import requests
import json


class prof:
    def __init__(self, profID, firstname, lastname, rating, numRatings, href):
    	self.profID = profID
    	self.firstName = firstname
    	self.lastName = lastname
    	self.rating = rating
    	self.numRatings = numRatings 
    	self.href = href


def extractProfs(url):
	f = open(url, 'r')

	tree = html.fromstring(f.read())
	profList = tree.xpath('//div[@class="result-list"][2]/ul/li/a')
	profs =[]
	ID = 0

	for pr in profList:
		href = pr.get("href")
		rating = pr.getchildren()[1].text
		name = pr.getchildren()[2].text.rstrip()
		firstName = name.split(',')[1].strip()
		lastName = name.split(',')[0].strip()
		numRatings = pr.getchildren()[2].getchildren()[0].text.split(' ')[0].rstrip()

		p = prof(ID,firstName, lastName, rating, numRatings, href)
		profs.append(p)
		ID+=1

	return profs

def saveToJSON(profs, filename):
	profsList = []

	for p in profs:
		dicti = {}
		dicti["profID"] = p.profID
		dicti["firstname"] = p.firstName
		dicti["lastname"] = p.lastName
		dicti["fullname"] = p.firstName + " " + p.lastName
		dicti["rating"] = p.rating
		dicti["numRatings"] = p.numRatings
		dicti["href"] = p.href;
		profsList.append(dicti)

	with open(filename, 'w') as outfile:
		json.dump(profsList,outfile ,indent=4)

def main():

	url = './data/rateMyProf.html'
	profs = extractProfs(url)

	saveToJSON(profs,"./data/profs.json")






if __name__ == '__main__':
    main()