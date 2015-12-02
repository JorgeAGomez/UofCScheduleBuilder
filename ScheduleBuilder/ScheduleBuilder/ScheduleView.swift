//
//  ScheduleView.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class ScheduleView: UIView {

    
    let days = 5
    let hours = 4
    let name = "New Schedule"
    let dept = "CPSC"
    let num = 599
    
    //var courses: [Course] = []
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // SetupColors
        let uofcColor = UIColor(hue: 353/360, saturation: 1, brightness: 0.88, alpha: 0.66)
        let tranparentWhite = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 0.66)
        
        // Create Rounded Background Box
        let backgroundBox = UIBezierPath(roundedRect: CGRectMake(0, 0, self.frame.width, self.frame.height), byRoundingCorners:.AllCorners, cornerRadii: CGSizeMake(8, 8))
        
        // Set Background Box Color & Draw
        uofcColor.setFill()
        backgroundBox.fill()
        
        // Set Date Format
        let formatter = NSDateFormatter()
        formatter.dateFormat = "h a"
        
        // Create New Start Time Objects
        let startTimeCalendar = NSCalendar.currentCalendar()
        let startTimeComps = NSDateComponents()
        
        // Set Actual Course Start Time
        startTimeComps.weekday = 2
        startTimeComps.hour = 11
        startTimeComps.minute = 0
        
        // Create Start Time
        let startTime = startTimeCalendar.dateFromComponents(startTimeComps)
        
        // Add Start Label to view
        var startLabel = UILabel(frame: CGRectMake(10, 10, self.frame.width - 15, 120))
        startLabel.textAlignment = NSTextAlignment.Left
        startLabel.font = startLabel.font.fontWithSize(12)
        startLabel.text = formatter.stringFromDate(startTime!)
        startLabel.textColor = UIColor.whiteColor()
        self.addSubview(startLabel)
        
        // Create New End Time Objects
        let endTimeCalendar = NSCalendar.currentCalendar()
        let endTimeComps = NSDateComponents()
        
        // Set Actual Course End Time
        endTimeComps.weekday = 2
        endTimeComps.hour = 13
        endTimeComps.minute = 50
        
        // Round the End Time Up
        if(endTimeComps.minute != 0){
            endTimeComps.minute = 0
            endTimeComps.hour = endTimeComps.hour + 1
        }
        
        // Create End Time
        let endTime = startTimeCalendar.dateFromComponents(endTimeComps)
        
        // Add End Label to view
        var endLabel = UILabel(frame: CGRectMake(10, 100, self.frame.width - 15, 120))
        endLabel.textAlignment = NSTextAlignment.Left
        endLabel.font = endLabel.font.fontWithSize(12)
        endLabel.textColor = UIColor.whiteColor()
        endLabel.text = formatter.stringFromDate(endTime!)
        self.addSubview(endLabel)
        
        // Set Schedule Title
        var titleLabel = UILabel(frame: CGRectMake(10, 5, self.frame.width - 15, 30))
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = titleLabel.font.fontWithSize(20)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "My Funtastic Schedule"
        self.addSubview(titleLabel)
        
        // Set Schedule Subtitle
        var subtitleLabel = UILabel(frame: CGRectMake(10, 30, self.frame.width - 15, 30))
        subtitleLabel.textAlignment = NSTextAlignment.Left
        subtitleLabel.font = subtitleLabel.font.fontWithSize(16)
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.text = dept + " " + String(num)
        self.addSubview(subtitleLabel)
        
        // Add Courses to Visualization
        let baseX = 55
        let baseY = 65
        let width = 55
        let height = 20
        
        let spaceX = 5
        let spaceY = 5
        
        
        //Int(round(endTime!.timeIntervalSinceDate(startTime!)))
        
        for day in 0..<days {
            for hour in 0..<hours{
                
                // Create Rounded Background Box
                var courseBox = UIBezierPath(roundedRect: CGRectMake(CGFloat(baseX) + CGFloat((width+spaceX)*(day)), CGFloat(baseY) + CGFloat((height+spaceY)*(hour)), CGFloat(width), CGFloat(height)), byRoundingCorners:.AllCorners, cornerRadii: CGSizeMake(5, 5))
                
                // Set Background Box Color & Draw
                tranparentWhite.setFill()
                courseBox.fill()
                
                // Set Course Number Label Inside of each Box
                var subtitleLabel = UILabel(frame:  CGRectMake(CGFloat(baseX) + CGFloat((width+spaceX)*(day)), CGFloat(baseY) + CGFloat((height+spaceY)*(hour)), CGFloat(width), CGFloat(height)))
                subtitleLabel.textAlignment = NSTextAlignment.Center
                subtitleLabel.font = subtitleLabel.font.fontWithSize(12)
                subtitleLabel.textColor = uofcColor
                subtitleLabel.text = String(num)
                self.addSubview(subtitleLabel)
                
                
            }
            
            
        }
        
        
        
        
        
    }

    

}
