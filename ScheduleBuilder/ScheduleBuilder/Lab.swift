//
//  Lab.swift
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
public class Lab: PEntity
{
    
    var number: Int = 1
    var time: [Time]
    //var professor: Prof
    
    
    init(number: Int, time: [Time])
    {
        self.number = number
        self.time = time
        //self.professor = professor
        
    }
    
}