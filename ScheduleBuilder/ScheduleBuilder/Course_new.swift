//
//  Course.swift
//  schedulerTest
//
//  Created by Nikita Ryzhenkov.
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
public class Course_new {
    
    var title:        String = ""      // Special Topics in Computer Science
    var courseCode:   String = ""      // CPSC
    var courseNumber: String = ""      // 599
    var department:   String = ""      // computer science
    var prereqs:      String = ""      // consent of department
    var description:  String = ""      // New areas in Computer Science. This course will...
    var favourited:   Bool = false
    var section:      Int?  = nil        // section 3
    var topic:        Int? = nil       // .83 (as in 599.83)
    var name:         String = ""      // 01
    var lectures:     [Lecture]        // Each lecture = each section.
    
    init()
    {
        lectures = []
    }
    
    init(title: String, courseCode: String, courseNumber: String, department: String, prereqs: String, description: String,lecture: [Lecture], name: String, section: String)
    {
        self.title = title
        self.courseCode = courseCode
        self.courseNumber = courseNumber
        self.department = department
        self.prereqs = prereqs
        self.description = description
        self.lectures = lecture
        self.name = name
        self.section = Int(section)
    }
    
    // Populates array of courses
    // unwrapsthe course into a list of periodics. Periodic is a combination of One Lecture One tutorial and one Lab,
    // essentially one schedualable unit.
    public func splitIntoPeriodics() -> [Periodic_new]
    {
        var periodics: [Periodic_new] = []
        
        for l in lectures
        {
            let numOfTuts = l.tutorials!.count
            let numOfLabs = l.labs!.count
            
            if numOfLabs != 0 && numOfTuts != 0
            {
                
                for tut in l.tutorials!
                {
                    for lab in l.labs!
                    {
                        var times:[[Time]] = [[],[],[]] //LEAVE DECLARATION AS IS otherwise compiler throws some pants on the head retarded error about CPU not supporting operation
                        times[0] = l.time
                        times[1] = tut.time
                        times[2] = lab.time
                        let periodic = Periodic_new(times: times, courseName: self.courseCode+" "+self.courseNumber, lectureNum: l.number, tutorialNum: tut.number, labNum: lab.number)
                        periodics.append(periodic)
                    }
                }
            }
                
            else if numOfTuts != 0
            {
                for tut in l.tutorials!
                {
                    var times:[[Time]] = [[],[],[]] //LEAVE DECLARATION AS IS otherwise compiler throws some pants on the head retarded error about CPU not supporting operation
                    times[0] = l.time
                    times[1] = tut.time
                    times[2] = []
                    let periodic = Periodic_new(times: times, courseName: self.courseCode+" "+self.courseNumber, lectureNum: l.number, tutorialNum: tut.number, labNum: nil)
                    periodics.append(periodic)
                }
            }
                
            else if numOfLabs != 0
            {
                for lab in l.labs!
                {
                    var times:[[Time]] = [[],[],[]] //LEAVE DECLARATION AS IS otherwise compiler throws some pants on the head retarded error about CPU not supporting operation
                    times[0] = l.time
                    times[1] = []
                    times[2] = lab.time
                    let periodic = Periodic_new(times: times, courseName: self.courseCode+" "+self.courseNumber, lectureNum: l.number, tutorialNum: nil, labNum: lab.number)
                    periodics.append(periodic)
                }
            }
            
            
        }
        return periodics
    }
    
    // One off design. We need this for creation of custom schedules in the SchedulesTabViewController
    // Essentially we are flattening the hierarchy making it so that we can translate a hierarchical data into flat
    // table of cells
    public func splitIntoCell() -> [CourseCellData]
    {
        var cells: [CourseCellData] = []
        var active = true
        var chosen = false
        
        for l in lectures
        {
            
            let cell = CourseCellData(type: "lecture", active: true, chosen: false, section: l.number, typeNumber: l.number, course: self.courseCode+" "+self.courseNumber,
                                      time: l.time)
            cells.append(cell)
            
            for tut in l.tutorials!
            {
                let cell = CourseCellData(type:"tutorial", active: true, chosen: false, section: l.number, typeNumber: tut.number, course: self.courseCode+" "+self.courseNumber, time: tut.time)
                cells.append(cell)
            }
            for lab in l.labs!
            {
                let cell = CourseCellData(type:"lab", active: true, chosen: false, section: l.number, typeNumber: lab.number ,course: self.courseCode+" "+self.courseNumber,
                                          time: lab.time)
                cells.append(cell)
            }
            
        }
        
        return cells
        
    }
    
    // One off design. We need this for creation of custom schedules in the SchedulesTabViewController
    // Essentially we are flattening the hierarchy making it so that we can translate a hierarchical data into flat
    // table of cells
    // FOR USE WHEN SCHEDULE ISN'T EMPTY. Hack if I ever saw one
    public func splitIntoCell(periodic: Periodic_new) -> [CourseCellData]
    {
        var cells: [CourseCellData] = []
        
        for l in lectures
        {
            var active = true
            var chosen = false
            
            //check if the Cell is the same as periodic
            if periodic.lectureNumber != l.number {
                active = false
                
            }
            else{ chosen = true}
            
            let cell = CourseCellData(type: "lecture", active: active, chosen: chosen,section: l.number, typeNumber: l.number, course: self.courseCode+" "+self.courseNumber,
                                      time: l.time)
            cells.append(cell)
            
            for tut in l.tutorials!
            {
//                if compareTimes(tut.time, t2: periodic.times[1]){
//                    active = true
//                    chosen = true
//                }
                if tut.number == periodic.tutorialNumber
                {
                    active = true
                    chosen = true
                }
                else
                {
                    active = false
                    chosen = false
                }
                
                let cell = CourseCellData(type:"tutorial", active: active, chosen: chosen, section: l.number, typeNumber: tut.number, course: self.courseCode+" "+self.courseNumber, time: tut.time)
                cells.append(cell)
            }
            
            for lab in l.labs!
            {
//                if compareTimes(lab.time, t2: periodic.times[2]){
//                    active = true
//                    chosen = true
//                }
                if lab.number == periodic.labNumber {
                    active = true
                    chosen = true
                }
                else
                {
                    active = false
                    chosen = false
                }
                
                let cell = CourseCellData(type:"lab", active: active, chosen: chosen, section: l.number, typeNumber: lab.number ,course: self.courseCode+" "+self.courseNumber,
                                          time: lab.time)
                cells.append(cell)
            }
            
        }
        
        return cells
        
    }
    
    // BAD REDO. USE SECTIONS TO COMPARE
    private func compareTimes(t1: [Time], t2: [Time]) -> Bool
    {
        for i in 0...t1.count-1 {
            if t1[i].day != t2[i].day || t1[i].fromTime != t2[i].fromTime || t1[i].toTime != t2[i].toTime {
                return false
            }
        }
        return true
    }
    
}