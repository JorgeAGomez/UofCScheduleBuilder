//
//  Periodics.swift
//  ScheduleBuilder
//
//  Created by Nik Ryzhenkov on 2016-02-02.
//  Copyright © 2016 Alexander "Ruthless" Ivanov. All rights preserved.
//

import Foundation

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
