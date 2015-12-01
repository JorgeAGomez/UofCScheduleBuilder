//
//  Data.swift
//  schedulerTest
//
//  Created by Fadi Botros on 2015-11-22.
//  Copyright © 2015 Fadi Botros. All rights reserved.
//

import Foundation

struct GlobalVariables {
    static var data: Data!
}


class Data {
    
    var courses = [Course]()
    var profs = [Prof]()
    var offerings = [Offering]()
    var departments = [String]()
    
    func processCourses( crs : NSArray)
    {
        for dict : NSDictionary in crs as! Array
        {
            let newCourse = Course(dict: dict)
            self.courses.append(newCourse)
            
            if(departments.contains(newCourse.department) == false)
            {
                self.departments.append(newCourse.department)
            }
        }
    }
    
    func processProfs( prfs :  NSArray)
    {
        for dict : NSDictionary in prfs as! Array
        {
            self.profs.append(Prof(dict: dict))
        }
    }
    
    func processOfferings(prdcs : NSArray)
    {
        for dict : NSDictionary in prdcs as! Array
        {
            self.offerings.append(Offering(dict: dict))
        }
    }
    
    func matchCoursesAndOfferings()
    {
        for o in self.offerings
        {
            for c in self.courses
            {
                if(o.courseCode == c.courseCode && o.courseNumber == c.courseNumber)
                {
                    c.offering = o
                    o.course = c
                    break;
                }
            }
        }
    }
    
    func findProfByName(fullname : String) -> Prof?
    {
        for p in self.profs
        {
            if(p.fullname == fullname)
            {
                return p
            }
        }
        
        return nil
    }
    
    
    func matchOfferingsAndProfs()
    {
        for o in self.offerings
        {
            for p in o.periodics
            {
                for(profText, matchedProfText) in zip(p.profsText, p.matchedProfsText)
                {
                    if(profText == "Staff") {break}
                    
                    // a prof with a match
                    else if( profText != "Staff" && matchedProfText != "None")
                    {
                        if(self.findProfByName(matchedProfText) == nil)
                        {
                            print("fuck")
                        }
                        
                        p.profs.append(self.findProfByName(matchedProfText)!)
                    }
                    
                    else if(profText != "Staff" && matchedProfText != "None")
                    {
                        let foundProf = self.findProfByName(profText)
                        
                        if(foundProf != nil)
                        {
                            p.profs.append(foundProf!)
                        }
                        else
                        {
                            let newProf = Prof(fullname: profText)
                            self.profs.append(newProf)
                            p.profs.append(newProf)
                        }
                    }
                    
                }
            }
        }
    }
    
    func getAllCoursesFromDepartment(department : String) -> [Course]
    {
        var out = [Course]()
        
        for c in self.courses where c.department == department{
            out.append(c)
        }
        
        return out
    }

    func readjson(fileName: String, fileType: String) -> NSArray{
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        let jsonData : NSData = try! NSData(contentsOfFile: path! as String, options: NSDataReadingOptions.DataReadingMapped)
        let arr: NSArray!=(try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)) as! NSArray
        return arr
    }
    
    func getCourse(courseCode : String, courseNumber: String) -> Course?
    {
        for c in self.courses
        {
            if( c.courseCode == courseCode && c.courseNumber == courseNumber)
            {
                return c
            }
        }
        
        return nil
    }
    
    
    func appd(inout arr : [Int])
    {
        print("append")
        arr.append(2)
    }
    
    init()
    {
                
        let timeAtPress = NSDate()
        
        let p = readjson("profs", fileType: "json")
        processProfs(p)
        
        let crs = readjson("courses", fileType: "json")
        processCourses(crs)
        
        let offr = readjson("courseOfferings2", fileType: "json")
        processOfferings(offr)
        
        print(NSDate().timeIntervalSinceDate(timeAtPress))
        
        matchCoursesAndOfferings()
        
        print(NSDate().timeIntervalSinceDate(timeAtPress))
        
        matchOfferingsAndProfs()
        
        print(NSDate().timeIntervalSinceDate(timeAtPress))
        
        
////        let c1 = getCourse("ENEL", courseNumber: "500A")
//        let c2 = getCourse("CPSC", courseNumber: "599")
//        let c3 = getCourse("CPSC", courseNumber: "453")
//        let c4 = getCourse("SENG", courseNumber: "521")
//        let c5 = getCourse("SENG", courseNumber: "511")
//        
//        let offerings = [c2!.offering!, c3!.offering!, c4!.offering!, c5!.offering!]
//        
//        let s = Scheduler(offerings: offerings)
//        
//        let ss = s.getSchedules()
        
        
        


    }
    
    
}