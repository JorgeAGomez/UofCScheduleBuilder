# http://docs.python-guide.org/en/latest/scenarios/scrape/

from lxml import html
from lxml import etree
import xml.etree.cElementTree as ET
import requests
import json
import string


class course:
    def __init__(self, department, departmentCode, number, title, courseId, description, prereqs, prereqList):
        self.department = department  # engineering
        self.departmentCode = departmentCode  # ENGG
        self.number = number  # 511
        self.title = title  # Software Quality
        self.id = courseId  # 312312
        self.description = description  # blah blah blah
        self.prereqs = prereqs  # some string
        self.prereqList = prereqList


def extractCourseIDs(tree):
    courseIDs = tree.xpath('//tr/td/div[@class="item-container"]/a[@name]')
    retArr = []

    for c in courseIDs:
        if len(c.getparent().getchildren()) == 2:
            retArr.append(c.get("name"))

    return retArr


def extractPrereqCourseIDs(spanNode):
    courseIDs = []

    for c in spanNode.getchildren():
        cID = c.get('href').split('#')[-1]
        courseIDs.append(cID)


def getCoursesFromUrl(url):
    courses = []
    page = requests.get(url)
    tree = html.fromstring(page.text)
    courseIDs = extractCourseIDs(tree)
    courseCodes = tree.xpath('//span[@class="course-code"]')
    descriptions = tree.xpath('//span[@class="course-desc"]')
    prereqs = tree.xpath('//span[@class="course-prereq"]')
    # departmentCode = tree.xpath('//span[@class="page-title"]')[0].text[-4:].strip()
    departmentCode = tree.xpath('//span[@class="page-title"]')[0].text.split()[-1].strip()

    for num in range(0, len(courseIDs)):
        index = num * 3
        department = cleanText(courseCodes[index].text.strip())
        number = courseCodes[index + 1].text.strip()
        title = courseCodes[index + 2].text.strip()
        prereqCourseIDs = extractPrereqCourseIDs(prereqs[num])

        c = course(department, departmentCode, number, title, courseIDs[num], descriptions[num].text_content().strip(),
                   prereqs[num].text_content().strip(), prereqCourseIDs)
        courses.append(c)

    return courses


def getUrlsFromPage(startingURL):
    page = requests.get(startingURL)
    tree = html.fromstring(page.text)
    spans = tree.xpath('//span[@style="margin-left:15px;"]/a')

    hrefs = []
    for s in spans:
        hrefs.append(s.get('href'))

    return hrefs


def checkDuplicateIDs(courses):
    hs = set()

    for c in courses:
        if c.id in hs:
            print "DUPLICATES!"
        else:
            hs.add(c.id)


def cleanText(txt):
    return filter(lambda x: x in string.printable, txt)


def saveToXML(courses, filename):
    root = ET.Element("courses")

    for c in courses:
        cXML = ET.SubElement(root, "course")
        ET.SubElement(cXML, "id").text = c.id
        ET.SubElement(cXML, "department").text = c.department
        ET.SubElement(cXML, "departmentCode").text = c.departmentCode
        ET.SubElement(cXML, "number").text = c.number
        ET.SubElement(cXML, "title").text = c.title
        ET.SubElement(cXML, "description").text = c.description
        ET.SubElement(cXML, "prereqs").text = c.prereqs

    tree = ET.ElementTree(root)
    tree.write(filename)


def saveToJSON(courses, filename):
    coursesList = []

    for c in courses:
        dicti = {}
        dicti["id"] = c.id
        dicti["department"] = c.department
        dicti["departmentCode"] = c.departmentCode
        dicti["number"] = c.number
        dicti["title"] = c.title;
        dicti["description"] = c.description
        dicti["prereqs"] = c.prereqs
        coursesList.append(dicti)

    with open(filename, 'w') as outfile:
        json.dump(coursesList, outfile, indent=4)


def main():
    print "Hello"

    url = "http://www.ucalgary.ca/pubs/calendar/current/course-desc-main.html"
    # url = "http://www.ucalgary.ca/pubs/calendar/current/course-desc-d.html"
    hrefs = getUrlsFromPage(url)

    courses = []

    for h in hrefs:
        print "Scraping from:", h
        c = getCoursesFromUrl("http://www.ucalgary.ca/pubs/calendar/current/" + h)
        print len(c), "courses scraped"
        courses.extend(c)

    print "TOTAL COURSES:", len(courses)
    saveToJSON(courses, "./data/courses.json")


if __name__ == '__main__':
    main()