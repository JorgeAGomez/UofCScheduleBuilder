//
//  LineView.swift
//  CoursesPage
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class LineView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 3)
        
        CGContextMoveToPoint(context, 5, 0)
        CGContextAddLineToPoint(context, self.frame.width - 5, 0)

        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextStrokePath(context)
        
    }
    

}
