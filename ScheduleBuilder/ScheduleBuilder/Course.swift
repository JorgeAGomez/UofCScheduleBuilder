//
//  Course.swift
//  schedulerTest
//
//  Created by Fadi Botros on 2015-11-22.
//  Copyright © 2015 Fadi Botros. All rights reserved.
//

import Foundation

class Course {
    
    var title:  String = ""         //Special Topics in Computer Science
    var courseCode: String = ""     // CPSC
    var courseNumber: String = ""   // 599
    var department: String = ""     //computer science
    var prereqs: String = ""        //consent of department
    var description: String = ""    // New areas in Computer Science. This course will...
    var offering : Offering?
    var favourited: Bool = false
    
    init(){}
    
    init(title: String, courseCode: String, courseNumber: String, department: String, prereqs: String, description: String)
    {
        self.title = title
        self.courseCode = courseCode
        self.courseNumber = courseNumber
        self.department = department
        self.prereqs = prereqs
        self.description = description
        self.offering = nil
        
    }
    
    convenience init(dict: NSDictionary)
    {
        self.init( title: dict["title"] as! String,
        courseCode: dict["departmentCode"] as! String,
        courseNumber: dict["number"] as! String,
        department: dict["department"] as! String,
        prereqs: dict["prereqs"] as! String,
        description: dict["description"] as! String)
    }
    
    
    
}