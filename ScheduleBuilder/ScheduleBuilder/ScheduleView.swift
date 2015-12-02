//
//  ScheduleView.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class ScheduleView: UIView {

    
    let uofcColor = UIColor(hue: 353/360, saturation: 0.66, brightness: 0.88, alpha: 1.00)
    let tranparentWhite = UIColor(hue: 0, saturation: 0.1, brightness: 1.00, alpha: 1.00)
    
    let days = 5
    var hours = 0
    let name = "New Schedule"
    let dept = "CPSC"
    let num = 599
    
    var events: [ScheduleEvent] = []
    
    var scheduleHours = CGFloat(0)
    
    var subtitle = ""
    
    var timetable: [[Int]] = []
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // Firgure out schedule Start and Stop time
        
        var scheduleStartTime = 23.75
        var scheduleEndTime = 0.0
        
        var scheduleStartText = "00 AM"
        var scheduleEndText = "00 PM"
        
        var courseCodes: [String] = []
        
        for event in events{
            let eventTimes = event.times
            
            if(!courseCodes.contains(event.offering.courseCode + " " + event.offering.courseNumber)){
                
                courseCodes.append(event.offering.courseCode + " " + event.offering.courseNumber)
                
                if(subtitle == ""){
                    subtitle += event.offering.courseCode + " " + event.offering.courseNumber
                }
                    
                else{
                    subtitle += ", " + event.offering.courseCode + " " + event.offering.courseNumber
                }
            }
            
            
            for time in eventTimes{
                if (time.fromTime < scheduleStartTime){
                    scheduleStartTime = time.fromTime
                    scheduleStartText = time.fromTimeText
                }
                
                if (time.toTime > scheduleEndTime){
                    scheduleEndTime = time.toTime
                    scheduleEndText = time.toTimeText
                }
            }
        }
        
        ceil(CGFloat(scheduleStartTime-1))
        
        scheduleHours = ceil(CGFloat(scheduleEndTime)) - ceil(CGFloat(scheduleStartTime-1))
        
        
        hours = Int(scheduleHours)
        
        
        
        
        // Create Rounded Background Box
        let backgroundBox = UIBezierPath(roundedRect: CGRectMake(0, 0, self.frame.width, self.frame.height), byRoundingCorners:.AllCorners, cornerRadii: CGSizeMake(8, 8))
        
        // Set Background Box Color & Draw
        uofcColor.setFill()
        backgroundBox.fill()
        
        
        // Add Start Label to view
        var startLabel = UILabel(frame: CGRectMake(10, 60, 40, 15))
        startLabel.backgroundColor = uofcColor
        startLabel.textAlignment = NSTextAlignment.Left
        startLabel.font = startLabel.font.fontWithSize(12)
        startLabel.text = scheduleStartText
        startLabel.textColor = UIColor.whiteColor()
        self.addSubview(startLabel)
        
        // Add End Label to view
        var endLabel = UILabel(frame: CGRectMake(10, 160, 40, 15))
        endLabel.backgroundColor = uofcColor
        endLabel.textAlignment = NSTextAlignment.Left
        endLabel.font = endLabel.font.fontWithSize(12)
        endLabel.textColor = UIColor.whiteColor()
        endLabel.text = scheduleEndText
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
        subtitleLabel.font = subtitleLabel.font.fontWithSize(14)
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.text = subtitle
        self.addSubview(subtitleLabel)
        
        
        
        let baseX = 55
        let baseY = 65
        
        let width = 55
        let height = (Int(frame.height) - baseY)/(hours + 1)
        
        let spaceX = 5
        let spaceY = height/8
        
        
        // Create Rounded Boxes
        var dayNum = 0
        for event in events{
            for time in event.times{
                
                // Get day number
                switch time.day {
                    
                case "Mon":
                    dayNum = 0
                    break
                case "Tue":
                    dayNum = 1
                    break
                case "Wed":
                    dayNum = 2
                    break
                case "Thu":
                    dayNum = 3
                    break
                case "Fri":
                    dayNum = 4
                    break
                case "Sat":
                    dayNum = 5
                    break
                case "Sun":
                    dayNum = 6
                    break
                default:
                    dayNum = 7
                    break
                    
                }
                
                // exclude weekends for now...
                if(dayNum < 5){
                    
                    // calculate size
                    var beginBoxX = CGFloat(baseX) + CGFloat(dayNum * (width + spaceX))
                    var beginBoxY = CGFloat(baseY) + CGFloat(time.fromTime - scheduleStartTime)/scheduleHours * (frame.height - CGFloat(baseY))
                    
                    var widthBox = CGFloat(width)
                    var heightBox = CGFloat(baseY) + CGFloat(time.toTime - scheduleStartTime)/scheduleHours * (frame.height - CGFloat(baseY)) - beginBoxY
                    
                    var courseBox = UIBezierPath(roundedRect: CGRectMake(beginBoxX, beginBoxY, widthBox, heightBox), byRoundingCorners:.AllCorners, cornerRadii: CGSizeMake(3, 3))
                    
                    // draw box
                    tranparentWhite.setFill()
                    courseBox.fill()
                    
                    
                    // Set Course Number Label Inside of each Box
                    var subtitleLabel = UILabel(frame:  CGRectMake(beginBoxX, beginBoxY, widthBox, heightBox))
                    subtitleLabel.textAlignment = NSTextAlignment.Center
                    subtitleLabel.font = subtitleLabel.font.fontWithSize(12)
                    subtitleLabel.textColor = uofcColor
                    subtitleLabel.text = event.offering.courseNumber
                    self.addSubview(subtitleLabel)
                    
                    
                }
            }
        }
        
        
    }

    

}
