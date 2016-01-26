//
//  Offering.swift
//  schedulerTest
//
//  Created by Fadi Botros on 2015-11-23.
//  Copyright © 2015 Fadi Botros. All rights reserved.
//

import Foundation

class Offering{
    
    var title:  String = ""         //Special Topics in Computer Science
    var courseCode: String = ""     // CPSC
    var courseNumber: String = ""   //599
    var periodics = [Periodic]()
    var course : Course
    
    var section: Int = -1   // TO BE IMPLEMENTED: section number (so a lecture in sec 1 only works with tut in sec 1)
    var topic: Int = -1    // TO BE IMPLEMENTED: topic number for "Special Topic" courses
    
    
    init(title : String, courseCode : String, courseNumber : String, periodicsRaw : [NSDictionary])
    {
        self.title = title
        self.courseNumber = courseNumber
        self.courseCode = courseCode
        self.course = Course()
        self.periodics = self.convertPeriodics(periodicsRaw)
    }
    
    func convertPeriodics(arr : [NSDictionary]) -> [Periodic]
    {
        var out = [Periodic]()
        
        for dict : NSDictionary in arr
        {
            out.append(Periodic(dict: dict))
        }
        
        return out
    }
    
    
    convenience init(dict : NSDictionary)
    {
        let title = dict["description"] as! String
        let courseNumber = dict["courseNumber"] as! String
        let courseCode = dict["courseCode"] as! String
        let periodicsRaw = dict["periodics"] as! [NSDictionary]
        
        self.init(title: title, courseCode: courseCode, courseNumber: courseNumber, periodicsRaw: periodicsRaw)
    }
    
}

class Periodic{
    var profsText = [String]()
    var matchedProfsText = [String]()
    var times = [Time]()
    var profs = [Prof]()
    var type = ""       //Tutorial
    
    init(profsText : [String], matchedProfsText : [String], times : [NSDictionary], type: String)
    {
        self.profsText = profsText
        self.matchedProfsText = matchedProfsText
        self.times = self.convertTimes(times)
        self.type = type
    }
    
    func convertTimes(arr : [NSDictionary]) -> [Time]
    {
        var out = [Time]()
        
        for dict : NSDictionary in arr
        {
            out.append(Time(dict: dict))
        }
        
        return out
    }
    
    convenience init(dict : NSDictionary)
    {
        let type = dict["type"] as! String
        let matchedNames = dict["matchedNames"] as! [String]
        let profsText = dict["instructor"] as! [String]
        var timesText = [NSDictionary]() //dict["times"] as! [NSDictionary]
        
        if(dict["times"] != nil){
            timesText = dict["times"] as! [NSDictionary]
        }
        
        
        self.init(profsText: profsText, matchedProfsText: matchedNames, times: timesText, type: type)
    }
}


class Time{
    var day = ""                //Tues
    var fromTimeText = ""       //12:30
    var toTimeText = ""         //13:30
    var fromTime = 0.0          //12.5
    var toTime = 0.0            //13.5
    
    init(fromTimeStr : String, toTimeStr : String, day : String)
    {
        self.day = day
        self.fromTimeText = fromTimeStr
        self.toTimeText = toTimeStr
        self.fromTime = self.convertTimeToDouble(fromTimeStr)
        self.toTime = self.convertTimeToDouble(toTimeStr)
    }
    
    convenience init(dict : NSDictionary)
    {
        self.init( fromTimeStr: dict["fromTime"] as! String,
            toTimeStr: dict["toTime"] as! String,
            day: dict["day"] as! String)
    }
    
    func convertTimeToDouble(time : String) -> Double{
        let t = time.componentsSeparatedByString(":")
        
        let hours = Double(t[0])
        let minutes = Double(t[1])! / 60.0
        
        return hours! + minutes
    }
}