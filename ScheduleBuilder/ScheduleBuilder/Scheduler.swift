//
//  Scheduler.swift
//  schedulerTest
//
//  Created by Fadi Botros on 2015-11-30.
//  Copyright © 2015 Fadi Botros. All rights reserved.
//

import Foundation


class Scheduler{
    
    var offerings = [Offering]()
    
    init( offerings : [Offering] )
    {
        self.offerings = offerings
    }
    
    
    func getPeriodicTypes(offering : Offering) -> [String]
    {
        var types = [String]()
        
        for p in offering.periodics
        {
            if(types.contains(p.type) == false)
            {
                types.append(p.type)
            }
        }
        
        return types
    }
    
    func getPeriodics(offering : Offering, type : String) -> [Periodic]
    {
        var out = [Periodic]()
        
        for p in offering.periodics
        {
            if(p.type == type)
            {
                out.append(p)
            }
        }
        
        return out
    }
    
    func getAllOfferingCombo(offering : Offering) -> [[ScheduleEvent]]
    {
        let types = getPeriodicTypes(offering)
        
        var allCombos = [[ScheduleEvent]]()
        
        getAllOfferingComboRecrs(offering, types: types, typeIndex: 0 ,currList: [ScheduleEvent](), allCombos: &allCombos)
        
        return allCombos
    }
    
    func timeOverlap(t1 : Time, t2 : Time) -> Bool
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
    
    func ScheduleEventOverlap(se1 : ScheduleEvent, se2 : ScheduleEvent) -> Bool
    {
        for t1 in se1.times
        {
            for t2 in se2.times
            {
                if(timeOverlap(t1, t2: t2) == true)
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    func scheduleFit(arr : [ScheduleEvent] , se : ScheduleEvent) -> Bool
    {
        for a in arr
        {
            if( ScheduleEventOverlap(a , se2: se) == true )
            {
                return false
            }
        }
        
        return true
    }
    
    func scheduleFit(arr1 : [ScheduleEvent] , arr2 : [ScheduleEvent]) -> Bool
    {
        for a in arr1
        {
            if(scheduleFit(arr2 , se: a) == false)
            {
                return false
            }
        }

        return true
    }
    
    //used in initial seeding
    func getAllOfferingComboRecrs(
        offering : Offering,
        types :[String],
        typeIndex : Int,
        var currList : [ScheduleEvent],
        inout allCombos : [[ScheduleEvent]])
    {
        if(typeIndex >= types.count)
        {
            allCombos.append(currList)
            return
        }
        
        let currType = types[typeIndex]
        let periodics = getPeriodics(offering, type: currType)
        
        for p in periodics{
            let se = ScheduleEvent(offering: offering, type: p.type, times: p.times)
            
            if(scheduleFit(currList, se: se) == true){
                currList.append(se)
                getAllOfferingComboRecrs(offering,types: types,typeIndex: typeIndex + 1, currList: currList, allCombos: &allCombos)
                currList.removeLast()
            }
        }

    }
    
    //used in actual making of the schedules
    func getScheduleComboRecrs(
        offeringCombos : [[ScheduleEvent]],
        offrIndex : Int,
        var currList: [ScheduleEvent],
        inout allSchedules : [Schedule])
    {
        if( offrIndex >= offeringCombos.count)
        {
            allSchedules.append(Schedule(se: currList))
            return
        }
        
        
        getScheduleComboRecrs(offeringCombos, offrIndex: offrIndex + 1, currList: currList, allSchedules: &allSchedules)
        
        if( scheduleFit(currList,  arr2: offeringCombos[offrIndex]) == true)
        {
            currList.appendContentsOf(offeringCombos[offrIndex])
            getScheduleComboRecrs(offeringCombos, offrIndex: offrIndex + 1, currList: currList, allSchedules: &allSchedules)
        }
    }
    
    func getSchedules() -> [Schedule]
    {
        var schedules = [Schedule]()
        var offerringCombos = [[ScheduleEvent]]()
        
        for o in self.offerings{
            offerringCombos.appendContentsOf(self.getAllOfferingCombo(o))
        }
        
        getScheduleComboRecrs(offerringCombos, offrIndex: 0, currList: [ScheduleEvent](), allSchedules: &schedules)
        
        schedules.removeFirst()
        
        var highestNumOfCourses = 0
        
        for s in schedules {
            if( s.courses.count > highestNumOfCourses) { highestNumOfCourses = s.courses.count}
        }
        
        //some schedules will have only one course
        return schedules.filter( { $0.courses.count  == highestNumOfCourses})
    }
}

class ScheduleEvent{
    
    var offering : Offering
    var type : String = ""
    var times = [Time]()
    
    init(offering : Offering, type : String, times : [Time])
    {
        self.offering = offering
        self.type = type
        self.times = times
    }
}

class Schedule{
    
    var events = [ScheduleEvent]()
    var courses = [Course]()
    
    init(se : [ScheduleEvent])
    {
        self.events = se
        extractCourses()
    }
    
    private func extractCourses()
    {
        for e in events
        {
            let c = e.offering.course
            if(self.courses.contains( {$0.courseCode == c.courseCode && $0.courseNumber == c.courseNumber})  == false )
            {
                self.courses.append(e.offering.course)
            }
        }
    }
}