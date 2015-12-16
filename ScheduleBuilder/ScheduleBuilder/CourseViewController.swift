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
    @IBOutlet weak var subtitleToolBar: UIToolbar!
    @IBOutlet weak var subtitleBarItem: UIBarButtonItem!
    
    var course : Course = Course()
    
    let faveButton: UIButton = UIButton(type: UIButtonType.Custom)
    var faveImage: UIImage = UIImage(named:"fullHeart.png")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        subtitleToolBar.clipsToBounds = true
        
        //subtitleToolBar.setShadowImage(nil, forToolbarPosition: UIBarPosition.TopAttached)
        
        //subtitleToolBar.layer.shadowOffset = CGSizeMake(0, 0)
        
        //subtitleToolBar.barTintColor = UIColor.whiteColor()
        subtitleBarItem.tintColor = UIColor.blackColor()
        subtitleToolBar.barPosition
        
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        // Prepare to Add Favourite Button in Navigation Bar
        self.navigationItem.rightBarButtonItem = nil;
        faveButton.frame = CGRectMake(0, 0, 28, 25)
        faveButton.tintColor = UIColor.redColor()
        
        
        // Decide what Image to fill with
        if(course.favourited == true){
            faveButton.setImage(UIImage(named:"fullHeart.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        }
        else{
            faveButton.setImage(UIImage(named:"emptyHeart.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        }
        
        // Add the Favourite Button to the Navigation Bar
        faveButton.addTarget(self, action: "RighttNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: faveButton)
        self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
        
        // Add Interaction to the Favourite Button
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("favouriteTapped:"))
        faveButton.userInteractionEnabled = true
        faveButton.addGestureRecognizer(tapGestureRecognizer)
        
        // Add the Course title and Description
        
        self.title = course.courseCode + " " + course.courseNumber;
        
        let barsubtitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: subtitleToolBar.frame.width/1.8, height: 66))
        barsubtitleLabel.numberOfLines = 0
        barsubtitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        barsubtitleLabel.text = course.title
        barsubtitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        //barsubtitleLabel.textColor = UIColor.blueColor()
        barsubtitleLabel.textAlignment = .Center
        subtitleBarItem.customView = barsubtitleLabel
        
        
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        courseDescriptionLabel.text = course.description
        coursePrereqLabel.text = "Prerequisites: " + course.prereqs
        
     
        
        /*
        
        if(course.favourited == true){
            favouriteImage.image = UIImage(named: "fullHeart")
        }
        else{
            favouriteImage.image = UIImage(named: "emptyHeart")
        }
        
        
        favouriteImage.image = favouriteImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        favouriteImage.tintColor = UIColor.redColor()

        */
        
        /*
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("favouriteTapped:"))
        favouriteImage.userInteractionEnabled = true
        favouriteImage.addGestureRecognizer(tapGestureRecognizer)
        */

        
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
                        //let r = String(prof.rating) // the actual rating number
                        let fillStars = String(count: Int(round(prof.rating)),repeatedValue: Character("★"))
                        let unfillStars = String(count: 5 - Int(round(prof.rating)),repeatedValue: Character("☆"))
                        txt += prof.fullname + " " + fillStars + unfillStars + "\n"
                        txt += "RMP : www.ratemyprofessors.com" + prof.href + "\n"
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
    
    func favouriteTapped(img: AnyObject)
    {
        if(course.favourited == false){
            course.favourited = true
            faveButton.setImage(UIImage(named:"fullHeart.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)

            
        }
        else{
            course.favourited = false
            faveButton.setImage(UIImage(named:"emptyHeart.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)

        }
    }
    
    
    
    func setupOfferingList(){
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

