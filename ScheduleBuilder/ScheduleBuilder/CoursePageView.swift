//
//  CoursePageView.swift
//  CoursesPage
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class CoursePageView: UIView {

    let backgroundBoxColour = UIColor(hue: 0, saturation: 0.1, brightness: 1.00, alpha: 1.00)
    
    var isOpen = false
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // Create Top Rounded Background Box
        let backgroundBox = UIBezierPath(roundedRect: CGRectMake(0, 0, self.frame.width, 30), byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(8, 8))
        
        // Set Background Box Color & Draw
        backgroundBoxColour.setFill()
        backgroundBox.fill()
        
        
        // Set Schedule Title
        var titleLabel = UILabel(frame: CGRectMake(10, 5, self.frame.width - 15, 30))
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = titleLabel.font.fontWithSize(20)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "New Schedule"
        self.addSubview(titleLabel)
        
    }
    

}
