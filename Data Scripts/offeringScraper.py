# http://docs.python-guide.org/en/latest/scenarios/scrape/

from lxml import html
import requests
import json
import xml.etree.ElementTree

class pTime:
	def __init__(self, day, fromTime, toTime):
		self.day = day
		self.fromTime = fromTime
		self.toTime = toTime

class periodic:
	def __init__(self, pType, instructor, group, name):
		self.pType = pType
		self.instructor = instructor
		self.pTimes = []
		self.group = group
		self.name = name

	def appendPTime(self, day, fromTime, toTime):
		p = pTime(day,fromTime, toTime)
		self.pTimes.append(p)

class offeredCourse:
	def __init__(self, courseCode, courseNumber, description):
		self.courseCode = courseCode
		self.courseNumber = courseNumber
		self.description = description
		self.periodics = []

	def appendPeriodic(self, p):
		# if len(self.periodics) == 0:
		# 	self.periodics.append(p)
		if all(self.comparePeriodicTimes(x,p) == False for x in self.periodics):
			self.periodics.append(p)

	def listContains(self, timeList, time):
 		for t in timeList:
			if t.day == time.day and t.fromTime == time.fromTime and t.toTime == time.toTime:
				return True
		return False

	#returns true if the two periodics are the same
	def comparePeriodicTimes(self, p1, p2):
		if p1.pType != p2.pType:
			return False

		if p1.instructor != p2.instructor:
			return False	

		if len(p1.pTimes) != len(p2.pTimes):
			return False

		if any( self.listContains(p2.pTimes, x) == False  for x in p1.pTimes):
			return False

		if any(self.listContains(p1.pTimes, x) == False  for x in p2.pTimes):
			return False

		return True


def extractOfferings(filename):
	e = xml.etree.ElementTree.parse(filename).getroot()
	allOfferedCourses = []

	for c in e.findall('course'):
		cCode = c.get('subject')
		cNumber = c.get('number')
		cDescription = c.findall("description")[0].text
		offCourse = offeredCourse(cCode, cNumber, cDescription)

		periodics = c.findall('periodic')
		for p in periodics:
			instructor = p.findall('instructor')[0].text
			
			if "Staff" in instructor:
				instructor = ["Staff"]
			else: 
				instructor = [x.strip() for x in instructor.split(',')]

			pType = p.get("type")
			times = p.findall('time')
			group = p.get("group")
			name = p.get("name")
			pdic = periodic(pType,instructor, group, name)

			for t in times:
				day = t.get('day')
				fromTime = t.get('time').split()[0]
				toTime = t.get('time').split()[-1]
				pdic.appendPTime(day,fromTime,toTime)

			offCourse.appendPeriodic(pdic)

		allOfferedCourses.append(offCourse)

	# for oc in allOfferedCourses:
	# 	print oc.courseCode + oc.courseNumber

	# 	for p in oc.periodics:
	# 		print "\t" + p.pType

	return allOfferedCourses


def saveToJSON(offerings, filename):
	offeringsList = []

	for o in offerings:
		dicti = {}
		dicti["courseCode"] = o.courseCode
		dicti["courseNumber"] = o.courseNumber
		dicti["description"] = o.description
		periodicsList = []

		for p in o.periodics:
			pDict = {}
			pDict["type"] = p.pType
			pDict["instructor"] = p.instructor
			pDict["group"] = p.group
			pDict["name"] = p.name

			timesList = []
			for t in p.pTimes:
				timesDict = {}
				timesDict["day"] = t.day
				timesDict["fromTime"] = t.fromTime
				timesDict["toTime"] = t.toTime
				timesList.append(timesDict.copy())

				pDict["times"] = timesList

			periodicsList.append(pDict.copy())

		dicti["periodics"] =  periodicsList
		offeringsList.append(dicti.copy())

	print len(offeringsList)

	with open(filename, 'w') as outfile:
		json.dump(offeringsList,outfile ,indent=4)

def main():

	url = './data/fall2015.xml'
	offerings = extractOfferings(url)
	saveToJSON(offerings, "./data/courseOfferings.json")


if __name__ == '__main__':
    main()