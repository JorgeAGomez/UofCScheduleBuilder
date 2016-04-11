//
//  descriptionHandler.swift
//  ScheduleBuilder
//
//  Created by Martin Kusch on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import Foundation
import SwiftyJSON

public class DescriptionHandler {
    var descriptions = [String:[String]]()
    
    init() {

        let descs = readJSON("courses", fileType: "json")
        collectDescriptions(descs)
        
    }
    
    private func collectDescriptions(dict : JSON) {
        var code: String
        var number: String
        var description: String
        var prereqs: String
        
        for (key, actualJSON):(String, JSON) in dict {
            description = actualJSON["description"].stringValue
            number = actualJSON["number"].stringValue
            code = actualJSON["departmentCode"].stringValue
            prereqs = actualJSON["prereqs"].stringValue
            if description.isEmpty {
                description = " "
            }
            if prereqs.isEmpty {
                prereqs = " "
            }
            
            descriptions[code + number] = [description, prereqs]
        }
        
    }
    
    public func getDescription(course: String) -> [String] {
        if let desc = descriptions[course] {
            return desc
        }
        else {
            return [" ", " "]
        }
    }
    
    //What do you think it does?
    private func readJSON (fileName: String, fileType: String) -> JSON{
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        let jsonData : NSData = try! NSData(contentsOfFile: path! as String, options: NSDataReadingOptions.DataReadingMapped)
        let jsond = JSON(data: jsonData)
        return jsond
    }
    
}