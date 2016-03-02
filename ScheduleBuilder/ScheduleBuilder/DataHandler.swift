//
//  DataHandler.swift
//  ScheduleBuilder
//
//  Created by Nik Ryzhenkov on 2016-02-02.
//  Copyright © 2016 Nik "The pretty one" Ryzhenkov. All rights reserved and shit.
//

import Foundation
import SwiftyJSON


public struct GlobalVariables2 {
    static var data: DataHandler!
}

public class DataHandler {
    
    public var courses = [Course_new]()
    var profs = [Prof]()
    var departments = [String]()
    
    
    init()
    {
        
        //        let timeAtPress = NSDate()
        //        let profsJSON = readJSON("courseOfferings2", fileType: "json")
        
        let crs = readJSON("courseOfferings2", fileType: "json")
        processCourses(crs)
        
        //        let coursesGeneralInfo = readJSON("courses", fileType: "json")
        
    }
    
    // Populates array of courses
    // @PARAMS:
    //   @dictionary: the entire JSON object associated with CourseOffering.JSON file
    // note: CourseOfferings.JSON is generated by a Python webscraper that is located outside the project
    private func processCourses( dictionary : JSON)
    {
        //Populate Courses directly with only available courses from the json file
        //this way we only display courses that are actually being offered
        //Keep all JSON relevant information here in this class
        //not inside Course/lab/tutorial etc. This should be the only place 
        //anything about JSON is known at all.
        
        
        var courseName:   String                        // Introduction to Computability
        var courseNumber: String                        // 313
        var courseCode:   String                        // CPSC
        var courseDescription: String = "DESCRIPTION"   //TODO: WRITE A JOIN PYTHON SCRUPT TO JOIN TO JSON FILES
        var courseDepartment:  String = "DEPARTMENT"    //TO GET ALL THAT INFO IN ONE PLACE
        var lectures: [Lecture] = []

        // I am not sure why this format, but that's what all tutorials suggest
        // key seems to be pretty useless and is not used
        for (key, actualJSON):(String, JSON) in dictionary
        {

            let periodics = actualJSON["periodics"]

            courseName   = actualJSON["description"].stringValue
            courseNumber = actualJSON["courseNumber"].stringValue
            courseCode   = actualJSON["courseCode"].stringValue
            courseDepartment = actualJSON["department"].stringValue
            
            if !departments.contains(courseDepartment)
            {
                departments.append(courseDepartment)
            }
            
            lectures     = getLectures(periodics)
            courses.append(Course_new(title: courseName, courseCode: courseCode, courseNumber: courseNumber, department: courseDepartment, prereqs: "", description: courseDescription, lecture: lectures))
        }
    }
    
    

    
    
    // Because of how JSON is set up right now with periodics (that is flatly) we need to group all tutorials/labs for each
    // course based on section number.
    // @PARAMS:
    //   @periodics: json representation of periodics section associated with a given course
    //   @sectionNumber: what do you think?
    // @RETURNS: a list of tutorials and a list of labs. Both or either one can be empty or have elements in them. Do an emptyCheck if using this function
    private func getLabsOrTutsForLectureWithSection(periodics: JSON, sectionNumber: Int) -> (tutorials: [PEntity], labs: [PEntity])
    {
        var tutorials: [PEntity] = []
        var labs:      [PEntity] = []
        
        // I am not sure why this format, but that's what all tutorials suggest
        // key seems to be pretty useless and is not used
        for (key, actualJSON):(String, JSON) in periodics
        {
            
            if actualJSON["section"].intValue == sectionNumber
            {
                var type = actualJSON["type"].stringValue
                if type == "Tutorial" || type == "Lab"
                {
                    var times: [Time] = []
                    for (key, actualJSON2):(String, JSON) in actualJSON["times"]
                    {
                        times.append(Time(dict: actualJSON2))
                    }
                    if type == "Tutorial"
                    {
                        tutorials.append(Tutorial(number: 1, time: times))
                    }
                    else
                    {
                        labs.append(Lab(number: 1, time: times))
                    }
                }
            }
        }
        
        return (tutorials, labs)
    }

    // Because of how JSON is set up right now with periodics (that is flatly) we need to group all tutorials/labs for each
    // course based on section number.
    // @PARAMS:
    //   @periodics: json representation of periodics section associated with a given course
    //   @sectionNumber: what do you think?
    // @RETURNS: a list of lectures. maybe empty
    private func getLectures(periodics: JSON) -> [Lecture]
    {
        var lectures: [Lecture] = []
        
        // I am not sure why this format, but that's what all tutorials suggest
        // key seems to be pretty useless and is not used
        for(key, actualJSON):(String, JSON) in periodics
        {
            if actualJSON["type"].stringValue == "Lecture"
            {
                var times: [Time] = []
                for (key, actualJSON2):(String, JSON) in actualJSON["times"]
                {
                    times.append(Time(dict: actualJSON2))
                }
                let lectureSection = 1
                let (tutorials, labs) = getLabsOrTutsForLectureWithSection(periodics,sectionNumber: 1)
                lectures.append(Lecture(number: lectureSection, time: times, tutorials: tutorials, labs: labs))
                
            }
        }
        
        return lectures
    
    }
    
    //TODO: ADD COMMENTS
    public func getFavourites()-> [Course_new]
    {
        var fav = [Course_new]()
        for c in self.courses where c.favourited == true{
            fav.append(c)
        }
        return fav
    }
    
    //TODO: ADD COMMENTS
    public func setFavourite(fav: Course_new){
        for c in self.courses{
            if(c.courseCode == fav.courseCode && c.courseNumber == fav.courseNumber)
            {
                c.favourited = true;
            }
        }
    }
    
    //TODO: ADD COMMENTS
    public func getAllCoursesFromDepartment(department: String) -> [Course_new]
    {
        var courses_out = [Course_new]()
        
        for c in self.courses where c.department == department
        {
            courses_out.append(c)
        }
        return courses_out 
    
    }
    
    //What do you think it does?
    private func readJSON (fileName: String, fileType: String) -> JSON{
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        let jsonData : NSData = try! NSData(contentsOfFile: path! as String, options: NSDataReadingOptions.DataReadingMapped)
        let jsond = JSON(data: jsonData)
        return jsond
    }

    
    
}