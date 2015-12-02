//
//  ViewController.swift
//  CoursesPage
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {

    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var courseDescriptionLabel: UITextView!
    @IBOutlet weak var coursePrereqLabel: UITextView!
    @IBOutlet weak var offeringDetails: UITextView!
    var course : Course = Course()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.title = course.courseCode + " " + course.courseNumber;
        courseDescriptionLabel.text = course.description
        coursePrereqLabel.text = "Prerequisites: " + course.prereqs
        ScrollView.contentSize.height = StackView.frame.height
        
        setupOfferingDetails()
    }
    
    func setupOfferingDetails()
    {
        if(course.offering != nil)
        {
            var txt = ""
            for p in (course.offering?.periodics)!
            {
                txt += p.type + "\n"
                
                if(p.profs.count > 0)
                {
                    for prof in p.profs{
                        let r = String(prof.rating)
                        txt += prof.fullname + " (" + r + ") \n"
                    }
                }
                
                for t in p.times{
                    txt += t.day + " " + t.fromTimeText + " - " + t.toTimeText + "\n"
                }
                
                txt += "\n"
            }
            
            txt = String(txt.characters.dropLast())
            txt = String(txt.characters.dropLast())
            
            offeringDetails.text = txt
        }
        else{
            offeringDetails.text = "Not offered this semester"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

