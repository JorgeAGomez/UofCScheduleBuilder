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
    var course : Course = Course()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.title = course.courseCode + " " + course.courseNumber;
        courseDescriptionLabel.text = course.description
        coursePrereqLabel.text = "Prerequisites: " + course.prereqs
        ScrollView.contentSize.height = StackView.frame.height
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

