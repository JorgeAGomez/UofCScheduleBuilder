//
//  Offering.swift
//  schedulerTest
//
//  Created by Fadi Botros on 2015-11-23.
//  Copyright © 2015 Fadi Botros. All rights reserved.
//

import Foundation

class Offering{
    
    var title:  String = ""         //Special Topics in Computer Science
    var courseCode: String = ""     // CPSC
    var courseNumber: String = ""   //599
    var periodics = [Periodic]()
    var course : Course
    
    var section: Int = -1   // TO BE IMPLEMENTED: section number (so a lecture in sec 1 only works with tut in sec 1)
    var topic: Int = -1    // TO BE IMPLEMENTED: topic number for "Special Topic" courses
    
    
    init(title : String, courseCode : String, courseNumber : String, periodicsRaw : [NSDictionary])
    {
        self.title = title
        self.courseNumber = courseNumber
        self.courseCode = courseCode
        self.course = Course()
        self.periodics = self.convertPeriodics(periodicsRaw)
    }
    
    func convertPeriodics(arr : [NSDictionary]) -> [Periodic]
    {
        var out = [Periodic]()
        
        for dict : NSDictionary in arr
        {
            out.append(Periodic(dict: dict))
        }
        
        return out
    }
    
    
    convenience init(dict : NSDictionary)
    {
        let title = dict["description"] as! String
        let courseNumber = dict["courseNumber"] as! String
        let courseCode = dict["courseCode"] as! String
        let periodicsRaw = dict["periodics"] as! [NSDictionary]
        
        self.init(title: title, courseCode: courseCode, courseNumber: courseNumber, periodicsRaw: periodicsRaw)
    }
    
}
