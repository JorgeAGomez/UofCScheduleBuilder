//
//  Schedule.swift
//  ScheduleBuilder
//
//  Created by Nik Ryzhenkov on 2016-02-06.
//  Copyright © 2016 Alexander "Thunder" Ivanov. All rights observed.
//

import Foundation

// The schedule is build using a gimpy AND_TREE implementation (AI concept). The idea is that we construct a tree looking for valid schedules.
class Schedule_new{
    
    // The reasoning here is that we will need both times and course information in the schedule.
    // Yes, storing both Course and Lecture/Tutorial/Lab arrays is redundant but I can't think of a better way atm
    // Hence, TODO: FIND A BETTER WAY TO IMPLEMENT THIS CLASS
    var lectures: [Lecture]
    var tutorial: [Tutorial]
    var labs:     [Lab]
    var courses:  [Course_new]
    
    // Purely for convienience. Instead of searching through each property for Time I'll just have to compare new Time against the existing here.
    // NOTE: this is a potential memory optimization case.
    var times:    [Time]
    
    init(se : [ScheduleEvent])
    {
        lectures = []
        courses  = []
        tutorial = []
        labs     = []
        times    = []
    }
    
}

