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
        barsubtitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 22.0)
        barsubtitleLabel.textColor = UIColor.blackColor()
        barsubtitleLabel.text = course.title
        barsubtitleLabel.textAlignment = .Center
        subtitleBarItem.customView = barsubtitleLabel
        
        
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        //courseDescriptionLabel.text = course.description
        //coursePrereqLabel.text = "Prerequisites: " + course.prereqs
        
     
        
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
        
        StackView.addArrangedSubview(makeSpace(5))
        
        // Add Course Description Label
        let courseDescriptionLabel = UILabel()
        courseDescriptionLabel.numberOfLines = 0
        courseDescriptionLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        
        let courseDescriptionStyle = NSMutableParagraphStyle()
        courseDescriptionStyle.alignment = NSTextAlignment.Justified
        
        let courseDescriptionText = NSAttributedString(string: course.description,
            attributes: [
                NSParagraphStyleAttributeName: courseDescriptionStyle,
                NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])
        
        courseDescriptionLabel.attributedText = courseDescriptionText
        
        StackView.addArrangedSubview(courseDescriptionLabel)
        
        // Add a Line with Spacing
        StackView.addArrangedSubview(makeSpace(5))
        StackView.addArrangedSubview(makeLine(StackView.frame.width, h: 1))
        StackView.addArrangedSubview(makeSpace(5))
        
        // Add Course Prerequisite Label
        let prereqLabel = UILabel()
        prereqLabel.numberOfLines = 0
        prereqLabel.font = UIFont(name: "HelveticaNeue", size: 16)

        let prereqStyle = NSMutableParagraphStyle()
        prereqStyle.alignment = NSTextAlignment.Justified
        
        let prereqText = NSAttributedString(string: "Prerequisites: " + course.prereqs,
            attributes: [
                NSParagraphStyleAttributeName: prereqStyle,
                NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])
        
        prereqLabel.attributedText = prereqText
        StackView.addArrangedSubview(prereqLabel)
        
        
        // Add a Line with Spacing
        StackView.addArrangedSubview(makeSpace(5))
        StackView.addArrangedSubview(makeLine(StackView.frame.width, h: 1))
        StackView.addArrangedSubview(makeSpace(5))
        
        
        let textLabel = UITextView()
        textLabel.widthAnchor.constraintEqualToConstant(self.view.frame.width).active = true
        textLabel.heightAnchor.constraintEqualToConstant(self.view.frame.height).active = true
        textLabel.textAlignment = .Left
        textLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        textLabel.editable = false
        textLabel.dataDetectorTypes = UIDataDetectorTypes.Link
        // If the course is offered this semester

        if(course.offering != nil){
            
            //textLabel.numberOfLines = 0

            var txt = ""
            for p in (course.offering?.periodics)!
            {
                txt += p.type + ": "
                
                if(p.profs.count > 0)
                {
                    for prof in p.profs{

                        let fillStars = String(count: Int(round(prof.rating)),repeatedValue: Character("★"))
                        let unfillStars = String(count: 5 - Int(round(prof.rating)),repeatedValue: Character("☆"))
                        
                        let ratingText = NSAttributedString(string: prof.fullname + " " + fillStars + unfillStars + "\n",
                            attributes: [
                                NSLinkAttributeName: "www.ratemyprofessors.com" + prof.href,
                            ])

                        
                        
                        
                        txt += prof.fullname + " " + fillStars + unfillStars + "\n"
                        txt += "RMP : www.ratemyprofessors.com" + prof.href + "\n"
                        
                        
                    }
                }
                
                else
                {
                        txt += "\n"
                }
                
                
                
                if(p.times.count > 0){
                
                    for t in p.times{
                        txt += t.day + ", "
                    }
                    txt = String(txt.characters.dropLast())
                    txt = String(txt.characters.dropLast())
                    
                    txt += " " + (p.times.first?.fromTimeText)! + " - " + (p.times.first?.toTimeText)! + "\n"
                    
                    txt += "\n"
                    
                }
                
                
                
                
                
                
            }
            
            textLabel.text = txt
            textLabel
            StackView.addArrangedSubview(textLabel)
            
        }
            
        // Else the course is not offered this semester
        else{
            //textLabel.numberOfLines = 0
            textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
            textLabel.heightAnchor.constraintEqualToConstant(300).active = true
            textLabel.textColor = UIColor.lightGrayColor()
            textLabel.text  = "\n\n\n\nCourse Not Offered this Semester\n\n"
            textLabel.textAlignment = .Center
            textLabel.sizeThatFits(textLabel.contentSize)
            textLabel.scrollEnabled = false
            StackView.addArrangedSubview(textLabel)

        }
        
        
        /*
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
        */
        
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
    
    
    func makeSpace(h: CGFloat) -> UIView{
        
        let space = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: h))
        let heightConstraint = NSLayoutConstraint(item: space, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: h)
        space.addConstraint(heightConstraint)
        
        return space
    }
    
    func makeLine(w: CGFloat, h: CGFloat) -> UIView{
        
        let line = LineView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        let heightConstraint = NSLayoutConstraint(item: line, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: h)
        line.addConstraint(heightConstraint)
        
        return line
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

