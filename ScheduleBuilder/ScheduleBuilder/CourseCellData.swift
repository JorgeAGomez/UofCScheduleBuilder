//
//  CourseCellData.swift
//  ScheduleBuilder
//
//  This is a one-off data type designed to help us implement
//  some of the trickier functionality in the app. Namely custom schedule creation
//  Turns out it's prety dificul to manage nested data in the context a table view
//  hence this pile of shit. Have any questions about it ask Nik
//
//
//  Created by Nik Ryzhenkov on 2016-03-19.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import Foundation

public class CourseCellData{

    var type:    String   // a Lecture, tutorial or a lab
    var time:    [Time]   // schedueld time
    var active:  Bool     // if it should be greyed out or not. false -> greyed out, true-> active
    var chosen:  Bool     // if it is marked or not
    var section: Int      // Section number of the lecture. same as in course_new
    var typeNumber: Int   // LeabNumber/TutorialNumber/LectureNumber etc.
    var motherCourse: String // string name of the course for identification
    
    
    init(type: String, active: Bool, chosen: Bool, section: Int,typeNumber: Int, course: String, time: [Time])
    {
        self.type = type
        self.time = time
        self.active = active
        self.chosen = chosen
        self.section = section
        self.typeNumber = typeNumber
        self.motherCourse = course
    }
    
}