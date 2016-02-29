//
//  ScheduleBuilder.swift
//  ScheduleBuilder
//
//  Created by Nik Ryzhenkov on 2016-02-06.
//  Copyright © 2016 Alexander "Shaolin" Ivanov. All rights reserved.
//

import Foundation

public class ScheduleBuilder
{
    var schedules: [Schedule_new]
    var courses:   [Course_new]             // Courses chosen by the user to make schedules out of. The favorited courses.
    
    
    let NUMBER_OF_SCHEDULES: Int            // CHANGE THIS NUMBER TO ADJUST NUMBER OF VALID SCHEDULES RETURNED
    private var validSchedulesCounter: Int
    
    var validSchedules: [[Periodic_new]] = []  // unsurprisingly, this is the aray of valid generated schedules
    
    init()
    {
        self.schedules = []
        self.courses   = []
        self.NUMBER_OF_SCHEDULES   = 15
        self.validSchedulesCounter = NUMBER_OF_SCHEDULES
    }
    
    init(favoritedCourses: [Course_new], NUMBER_OF_SCHEDULES: Int)
    {
        self.schedules = []
        self.courses   = favoritedCourses
        self.NUMBER_OF_SCHEDULES   = NUMBER_OF_SCHEDULES
        self.validSchedulesCounter = NUMBER_OF_SCHEDULES
    }
    
    
    public func createValidSchedules()
    {
        andTree([], coursesToSchedule: self.courses, indexOfActiveCourse: 0)
    }
    
    public func createValidSchedules(courses_list: [Course_new])
    {
        andTree([], coursesToSchedule: courses_list, indexOfActiveCourse: 0)
    }
    
    // A VERY rough implementation of an AndTree(Branch and bound search commonly found in AI).
    // Recursively explores the tree in "rounds" a round being a course.
    //                                              []
    // [Course1.Lecture1.Tutorial1] | [Course1.Lecture1.Tutorial2] | [Course1.Lecture2.Tutorial1]
    // [C1.L1.T1, C2.L1.Lab1]       |  [ C1.L1.T2, C2.L1.Lab1]     | [C1.L2.T1, C2.L1.Lab1]
    // etc etc etc.
    // it stops exploring a particular branch when: 
    // a) No more courses to schedule, aka all courses are already in the schedule
    // b) there is a time conflict
    // c) NUMBER_OF_SCHEDULES limit has been reached (everytime a valid schedule is created NUMBER_OF_SCHEDULES is incremented)
    //                        (this results in stoping of exploring any additional branches -> tree exits)
    // @PARAMS:
    //   @schedule: working schedule
    //   @coursesToSchedule: a list of courses that we are yet to schedule
    //   @indexOfActiveCourse: Im getting wierd errors with swift so this is a work around.
    //      we want to make sure that each round only one cours is worked on (round === tree level)
    // @RETURN:
    //   an array of valid schedules
    private func andTree(schedule: [Periodic_new], coursesToSchedule: [Course_new], indexOfActiveCourse: Int)
    {
        if validSchedules.count == NUMBER_OF_SCHEDULES
        {
            return
        }
        else
        {   if coursesToSchedule.count == indexOfActiveCourse
            {
                validSchedules.append(schedule)   // class variable
            }
            else
            {
                    for p in coursesToSchedule[indexOfActiveCourse].splitIntoPeriodics()
                    {
                        if isTimeConstraintMet(schedule, periodicToAdd: p)
                        {
                            var newSched = schedule
                            newSched.append(p)     //only doing this because of soem weird compiler bug. Honestly cannot figure out what the fuck it is
                            var new_indexOfActiveCourse = indexOfActiveCourse
                            new_indexOfActiveCourse += 1
                            andTree(newSched, coursesToSchedule: coursesToSchedule, indexOfActiveCourse: new_indexOfActiveCourse)
                        }
                    }
            }
        }
    }
    
    //TODO: write method to take periodic (complete or icomplete to add to schedule)
    
    // Populates array of courses
    // @PARAMS:
    //   @schedule: working schedule against which we are checking
    //   @periodicToAdd: a class+tut+lab that we are trying to put into the @schedule and therefore trying to see
    //                  if it fits in based on time slots.
    // @RETURN:
    //   true:  @periodicToAdd fits into the @schedule
    //   false: @periodicToAdd does not fit into the @schedule
    private func isTimeConstraintMet(schedule: [Periodic_new], periodicToAdd: Periodic_new) -> Bool
    {
        for p in schedule
        {
            if(PeriodicsOverlap(p, p2: periodicToAdd))
            {
                return false
            }
        }
        return true
    }
    
    
    // Comapres two Periodic_new to see if they overlap timewise.
    // Periodic_new.times is a [[]] with [0]->lecture, [1]->tut, [2]->lab, tut or lab can be empty arrays.
    // @PARAMS:
    //   @p1 @p2: two Periodic_new
    // @RETURN:
    //   true:  overlap
    //   false: do not overlap
    private func PeriodicsOverlap(p1 : Periodic_new, p2 : Periodic_new) -> Bool
    {
        for t1 in p1.times
        {
            for t2 in p2.times
            {
                for t2_time in t2
                {
                    for t1_time in t1
                    {
                        if(timeOverlap(t1_time, t2: t2_time) == true)
                        {
                            return true
                        }
                    }
                }
                
            }
        }
        
        return false
    }
    
    private func timeOverlap(t1 : Time, t2 : Time) -> Bool
    {
        if( t1.day == t2.day && t1.fromTime <= t2.toTime && t1.toTime >= t2.fromTime)
        {
            return true
        }
        else
        {
            return false
        }
    }

}