//
//  ScheduleDetailsViewController.swift
//  ScheduleBuilder
//
//  Created by Fadi Botros on 2015-12-02.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class ScheduleDetailsViewController: UIViewController {
    @IBOutlet weak var bodyText: UITextView!
    
    var scheduleTitle = "My Fantastic Schedule"
    var schedule: Schedule? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = scheduleTitle
        
        var bodytxt = ""
        
        for event in (schedule?.events)!{
            let courseTitle = event.offering.course.courseCode + " " + event.offering.course.courseNumber
            
            bodytxt += courseTitle + "\n"
            bodytxt += event.type + "\n"
            
            for t in event.times{
                bodytxt += t.day + " " + t.fromTimeText + " - " + t.toTimeText + "\n"
            }
            
            bodytxt += "\n"
        }

        bodyText.text = bodytxt
        
        var frame = bodyText.frame
        frame.size.height = bodyText.contentSize.height
        bodyText.frame = frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
