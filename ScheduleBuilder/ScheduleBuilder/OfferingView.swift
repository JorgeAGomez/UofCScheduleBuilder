//
//  OfferingViewTop.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class OfferingView: UIView {

    
    let backgroundBoxColour = UIColor(hue: 0, saturation: 0, brightness: 00.95, alpha: 1.00)

    var lecture:Lecture!
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {

        self.backgroundColor = UIColor.whiteColor()
        let secHeight:CGFloat = 30
        let spaceHeight:CGFloat = 10
        
        // Create Top Rounded Background Box
        let topBox = UIBezierPath(roundedRect: CGRectMake(0, 0, self.frame.width, secHeight), byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(8, 8))

        // Set Background Box Color & Draw
        backgroundBoxColour.setFill()
        topBox.fill()
        
        // Create Lecture Text
        let titleLabel = UILabel(frame: CGRectMake(10, 0, self.frame.width - 15, secHeight))
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)

        var titleText = "Lecture"
        
        if(lecture?.number != nil){
            titleText += " " + String(lecture.number) + "  "
        }
        
        titleLabel.text = titleText
        titleLabel.textColor = UIColor.blackColor()
        self.addSubview(titleLabel)
        
        // Create Lecture Time Text
        let timeLabel = UILabel(frame: CGRectMake(10, titleLabel.bounds.height/1.8, self.frame.width - 15, secHeight))
        timeLabel.textAlignment = NSTextAlignment.Left
        timeLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        
        var timeText = ""
        
        if(lecture?.time != nil){
            
            for t in lecture.time {
                timeText += t.day + " "
                
            }

            timeText += (lecture.time.first?.fromTimeText)! + " - "
            timeText += (lecture.time.first?.toTimeText)!
        }
        
        timeLabel.text = timeText
        timeLabel.textColor = UIColor.blackColor()
        self.addSubview(timeLabel)
        
        // Create Mid Background Box
        
        var subSections = 0
        
        if(lecture?.tutorials != nil){
            subSections += (lecture.tutorials?.count)!
        }
        
        if(lecture?.labs != nil){
            subSections += (lecture.labs?.count)!
        }
        
        let midBox = UIBezierPath(rect: CGRectMake(0, topBox.bounds.height, self.frame.width, (secHeight+spaceHeight)*CGFloat(subSections)))
        backgroundBoxColour.setFill()
        midBox.fill()
        
        // Create Tutorial & Lab Text
        
        var tutOffset:CGFloat = 0
        
        if(lecture?.tutorials != nil){
            
            
            
            for tut in lecture.tutorials!{
                
                var tutText = ""
                var tutTime = ""
                
                
                tutText = "Tutorial " + String(tut.number)
                
                for t in tut.time {
                    tutTime += t.day + " "
                }
                
                if(tut.time.first != nil){
                    tutTime += (tut.time.first?.fromTimeText)! + " - "
                    tutTime += (tut.time.first?.toTimeText)!
                }
                
                let tutLabel = UILabel(frame: CGRectMake(10, CGFloat(tutOffset*(secHeight+spaceHeight)) + (secHeight+spaceHeight) , self.frame.width - 15, secHeight))
                tutLabel.textAlignment = NSTextAlignment.Left
                tutLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
                tutLabel.text = tutText
                tutLabel.textColor = UIColor.blackColor()
                self.addSubview(tutLabel)
                
                let tutTimeLabel = UILabel(frame: CGRectMake(10, tutLabel.bounds.height/1.8 + CGFloat(tutOffset*(secHeight+spaceHeight)) + (secHeight+spaceHeight), self.frame.width - 15, secHeight))
                tutTimeLabel.textAlignment = NSTextAlignment.Left
                tutTimeLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
                tutTimeLabel.text = tutTime
                tutTimeLabel.textColor = UIColor.blackColor()
                self.addSubview(tutTimeLabel)
                
                tutOffset += 1
                
            }
        }
        
        var labOffset:CGFloat = tutOffset

        
        if(lecture?.labs != nil){
            
            for lab in lecture.labs!{
                
                var labText = ""
                var labTime = ""
                
                labText = "Lab " + String(lab.number)
                
                for t in lab.time {
                    labTime += t.day + " "
                }
                
                if(lab.time.first != nil){
                    labTime += (lab.time.first?.fromTimeText)! + " - "
                    labTime += (lab.time.first?.toTimeText)!
                }
                
                let labLabel = UILabel(frame: CGRectMake(10, CGFloat(labOffset*(secHeight+spaceHeight)) + (secHeight+spaceHeight) , self.frame.width - 15, secHeight))
                labLabel.textAlignment = NSTextAlignment.Left
                labLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
                labLabel.text = labText
                labLabel.textColor = UIColor.blackColor()
                self.addSubview(labLabel)
                
                let labTimeLabel = UILabel(frame: CGRectMake(10, labLabel.bounds.height/1.8 + CGFloat(labOffset*(secHeight+spaceHeight)) + (secHeight+spaceHeight), self.frame.width - 15, secHeight))
                labTimeLabel.textAlignment = NSTextAlignment.Left
                labTimeLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
                labTimeLabel.text = labTime
                labTimeLabel.textColor = UIColor.blackColor()
                self.addSubview(labTimeLabel)
                
                labOffset += 1
                
            }
        }

        
        
        
        
        // Create Bottom Background Box
        
        let btmBox = UIBezierPath(roundedRect: CGRectMake(0, topBox.bounds.height + midBox.bounds.height, self.frame.width, secHeight+spaceHeight), byRoundingCorners: [.BottomLeft, .BottomRight], cornerRadii: CGSizeMake(8, 8))
        backgroundBoxColour.setFill()
        btmBox.fill()
        
        //let hideLabel = UILabel(frame: CGRectMake(10, topBox.bounds.height + midBox.bounds.height, self.frame.width, secHeight+spaceHeight))
        //hideLabel.textAlignment = NSTextAlignment.Left
        //hideLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        //hideLabel.text = "Hide Tutorials & Labs"
        //hideLabel.textColor = UIColor.redColor()
        //self.addSubview(hideLabel)
        /*
        let hideButton = UIButton(type: UIButtonType.System) as UIButton
        hideButton.frame = CGRectMake(10, topBox.bounds.height + midBox.bounds.height, self.frame.width, secHeight+spaceHeight)
        //hideButton.backgroundColor = UIColor.greenColor()
        hideButton.setTitle("Hide Tutorials & Labs", forState: UIControlState.Normal)
        //hideButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)

        self.addSubview(hideButton)
*/
        
    }
    

}