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
public class Course_new {
    
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
        
        for l in lectures
        {
            let cell = CourseCellData(type: "lecture", active: true, section: l.number, typeNumber: l.number, course: self.courseCode+" "+self.courseNumber,
                                      time: l.time)
            cells.append(cell)
            
            for tut in l.tutorials!
            {
                let cell = CourseCellData(type:"tutorial", active: true, section: l.number, typeNumber: tut.number, course: self.courseCode+" "+self.courseNumber, time: tut.time)
                cells.append(cell)
            }
            for lab in l.labs!
            {
                let cell = CourseCellData(type:"lab", active: true, section: l.number, typeNumber: lab.number ,course: self.courseCode+" "+self.courseNumber,
                                          time: lab.time)
                cells.append(cell)
            }
            
        }
        
        return cells
        
    }
}