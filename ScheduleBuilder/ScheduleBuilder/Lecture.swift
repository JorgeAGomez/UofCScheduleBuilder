//
//  Lecture.swift
//  ScheduleBuilder
//
//  Created by Nik Ryzhenkov on 2016-02-03.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import Foundation

// Hierarchy:
// Course
//     |
//     |->[Lectures] (each lecture is individual section of a lecture)
//              |
//              |-> [Lab]
//              |-> [Tutorial]
public class Lecture: PEntity
{
    //Better name is section, but I still need to think about this one
    //and how to implement it
    var number:    Int = 1
    var time:      [Time]
    //var professor: Prof
    var tutorials: [PEntity]? = nil
    var labs:      [PEntity]? = nil
    

    
    init(number: Int, time: [Time], tutorials: [PEntity]?, labs: [PEntity]?)
    {
        self.number = number
        self.time = time
        //self.professor = professor
        self.tutorials = tutorials
        self.labs = labs
        
    }

}