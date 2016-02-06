//
//  Course.swift
//  schedulerTest
//
//  Created by Fadi Botros on 2015-11-22.
//  Copyright © 2016 Nikita "The Iceman" Ryzhenkov. All rights reserved.
//

import Foundation


// Hierarchy:
// Course
//     |
//      ->[Lectures] (each lecture is individual section of a lecture)
//              |
//               -> [Lab]
//               -> [Tutorial]
class Course_new {
    
    var title:        String = ""      // Special Topics in Computer Science
    var courseCode:   String = ""      // CPSC
    var courseNumber: String = ""      // 599
    var department:   String = ""      // computer science
    var prereqs:      String = ""      // consent of department
    var description:  String = ""      // New areas in Computer Science. This course will...
    var favourited:   Bool = false
    var section:      Int  = 0         // section 3
    var topic:        Int? = nil       // .83 (as in 599.83)
    var lectures:     [Lecture]        // Each lecture = each section.
    
    init()
    {
        lectures = []
    }
    
    init(title: String, courseCode: String, courseNumber: String, department: String, prereqs: String, description: String,lecture: [Lecture])
    {
        self.title = title
        self.courseCode = courseCode
        self.courseNumber = courseNumber
        self.department = department
        self.prereqs = prereqs
        self.description = description
        self.lectures = lecture
        
    }
}