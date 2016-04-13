//
//  Periodic_new.swift
//  ScheduleBuilder
//
//  Created by Nik Ryzhenkov on 2016-02-15.
//  Copyright © 2016 Alexander "AI" Ivanov. All rights reserved.
//

import Foundation

public struct Periodic_new
{
    var times:          [[Time]]   // [0] - lecture, [1] - tutorial, [2] - lab
    var labNumber:      Int?
    var courseName:     String
    var lectureNumber:  Int
    var tutorialNumber: Int?
    
    var toDraworNot: [Bool]       //  [0] - lecture, [1] - tutorial, [2] - lab
    
    init(times: [[Time]], courseName: String, lectureNum: Int, tutorialNum: Int?, labNum: Int?)
    {
        self.times = times
        self.labNumber = labNum
        self.courseName = courseName
        self.lectureNumber = lectureNum
        self.tutorialNumber = tutorialNum
        
        self.toDraworNot = [true,true,true]
    }
    
}