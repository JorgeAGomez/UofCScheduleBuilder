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
    let times:          [[Time]]   // [0] - lecture, [1] - tutorial, [2] - lab
    let labNumber:      Int?
    let courseName:     String
    let lectureNumber:  Int
    let tutorialNumber: Int?
    
    init(times: [[Time]], courseName: String, lectureNum: Int, tutorialNum: Int?, labNum: Int?)
    {
        self.times = times
        self.labNumber = labNum
        self.courseName = courseName
        self.lectureNumber = lectureNum
        self.tutorialNumber = tutorialNum
    }

}