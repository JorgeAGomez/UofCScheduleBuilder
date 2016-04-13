//
//  ScheduleDetailsViewController.swift
//  ScheduleBuilder
//
//  Created by Fadi Botros on 2015-12-02.
//  Copyright © 2015 Alexander "12-0-0" Ivanov. All rights reserved.
//

import UIKit

class ScheduleDetailsViewController: UIViewController {
    @IBOutlet weak var bodyText: UITextView!
    
    var scheduleTitle = "My Fantastic Schedule"
    var schedule: [Periodic_new]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = scheduleTitle
        
        var bodytxt = ""
        
        // We are essentially printing out the schedule in text format complete
        // with times, lectures, tutorials and labs numbers.
        for periodic in schedule!
        {
            let courseTitle = periodic.courseName
            bodytxt += courseTitle + "\n"
            
            bodytxt += "Lecture (L0\(periodic.lectureNumber)): " + "\n"
            for t in periodic.times[0]
            {
                bodytxt += t.day + " " + t.fromTimeText + " - " + t.toTimeText + "\n"
            }
            
            if periodic.times[1].count != 0
            {
                bodytxt += "Tutorial (T0\(periodic.tutorialNumber!)): " + "\n"
                for t in periodic.times[1]
                {
                    bodytxt += t.day + " " + t.fromTimeText + " - " + t.toTimeText + "\n"
                }
            }
            
            if periodic.times[2].count != 0
            {
                bodytxt += "Lab (l0\(periodic.labNumber!)): " + "\n"
                for t in periodic.times[2]
                {
                    bodytxt += t.day + " " + t.fromTimeText + " - " + t.toTimeText + "\n"
                }
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
