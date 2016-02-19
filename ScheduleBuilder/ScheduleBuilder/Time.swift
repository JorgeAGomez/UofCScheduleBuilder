//
//  Time.swift
//  ScheduleBuilder
//
//  Created by Nik Ryzhenkov on 2016-02-03.
//  Copyright © 2016 Darth Vader. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Time{
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
    
    convenience init(dict: JSON)
    {
        self.init( fromTimeStr: dict["fromTime"].stringValue,
            toTimeStr: dict["toTime"].stringValue,
            day: dict["day"].stringValue)

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