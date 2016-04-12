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
    
    var course : Course_new = Course_new()
    var favorite_courses : FavouriteCourses!   // CORE DATA
    
    let faveButton: UIButton = UIButton(type: UIButtonType.Custom)
    var faveImage: UIImage = UIImage(named:"fullHeart.png")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        subtitleToolBar.tintColor = self.navigationController?.navigationBar.tintColor
        
        
        //stackoverflow.com/questions/26390072/remove-border-in-navigationbar-in-swift
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(18)]
        
        //let bottomShadow = CALayer(layer: <#T##AnyObject#>)
        //bottomShadow.frame = subtitleToolBar.frame
        //bottomShadow.backgroundColor = UIColor.redColor().CGColor
      
        subtitleToolBar.addSubview(LineView())
        
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        

        
        //subtitleToolBar.clipsToBounds = true
        //self.navigationController?.navigationBar.clipsToBounds = true
        
        //subtitleToolBar.setShadowImage(nil, forToolbarPosition: UIBarPosition.TopAttached)
        
        //subtitleToolBar.layer.shadowOffset = CGSizeMake(0, 0)
        
        //subtitleToolBar.barTintColor = UIColor.whiteColor()
        //subtitleBarItem.tintColor = UIColor.blackColor()
        //subtitleToolBar.barPosition
        
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
        
        let barsubtitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: subtitleToolBar.frame.width/2, height: 66))
        barsubtitleLabel.numberOfLines = 0
        barsubtitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        barsubtitleLabel.font = UIFont.systemFontOfSize(18)
        barsubtitleLabel.textColor = UIColor.blackColor()
        barsubtitleLabel.text = course.title
        barsubtitleLabel.textAlignment = .Center
        subtitleBarItem.customView = barsubtitleLabel
        
        setupOfferingDetails()
        
        
        
    }
    
    
    func setupOfferingDetails()
    {
        
        StackView.addArrangedSubview(makeSpace(8))
        
        // Add Course Description Label
        
        //let courseDescriptionTitle = UILabel()
        //courseDescriptionTitle.numberOfLines = 0
        //courseDescriptionTitle.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        //courseDescriptionTitle.text = "Description"
        //StackView.addArrangedSubview(courseDescriptionTitle)

        
        if(course.description.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).isEmpty){
            
            
            
            let courseDescriptionLabel = UILabel()
            courseDescriptionLabel.numberOfLines = 0
            courseDescriptionLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
            
            let courseDescriptionStyle = NSMutableParagraphStyle()
            courseDescriptionStyle.alignment = NSTextAlignment.Left
            
            let courseDescriptionText = NSAttributedString(string: course.description,
                                                           attributes: [
                                                            NSParagraphStyleAttributeName: courseDescriptionStyle,
                                                            NSBaselineOffsetAttributeName: NSNumber(float: 0)
                ])
            
            courseDescriptionLabel.attributedText = courseDescriptionText
            
            StackView.addArrangedSubview(courseDescriptionLabel)
            
            // Add a Line with Spacing
            StackView.addArrangedSubview(makeSpace(8))
            //StackView.addArrangedSubview(makeLine(StackView.frame.width, h: 1))
            //StackView.addArrangedSubview(makeSpace(5))
            
            
        }
            
        // Add Course Prerequisite Labels
        
        if (!course.prereqs.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).isEmpty){
            let prereqTitle = UILabel()
            prereqTitle.numberOfLines = 0
            prereqTitle.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
            prereqTitle.text = "Prerequisites"
            StackView.addArrangedSubview(prereqTitle)
            StackView.addArrangedSubview(makeSpace(2))
            
            
            let prereqLabel = UILabel()
            prereqLabel.numberOfLines = 0
            prereqLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
            
            let prereqStyle = NSMutableParagraphStyle()
            prereqStyle.alignment = NSTextAlignment.Left
            
            let prereqText = NSAttributedString(string: course.prereqs,
                attributes: [
                    NSParagraphStyleAttributeName: prereqStyle,
                    NSBaselineOffsetAttributeName: NSNumber(float: 0)
                ])
            
            prereqLabel.attributedText = prereqText
            StackView.addArrangedSubview(prereqLabel)
            StackView.addArrangedSubview(makeSpace(8))

        }
        
        else{
            let prereqTitle = UILabel()
            prereqTitle.numberOfLines = 0
            prereqTitle.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
            //prereqTitle.textColor = UIColor.redColor()
            prereqTitle.text = "No Prerequisites"
            StackView.addArrangedSubview(prereqTitle)
            StackView.addArrangedSubview(makeSpace(2))
        }
        
        // Add a Line with Spacing
        //StackView.addArrangedSubview(makeSpace(5))
        //StackView.addArrangedSubview(makeLine(StackView.frame.width, h: 1))
        //StackView.addArrangedSubview(makeSpace(5))
        
        
        let textLabel = UITextView()
        textLabel.widthAnchor.constraintEqualToConstant(self.view.frame.width).active = true
        textLabel.heightAnchor.constraintEqualToConstant(self.view.frame.height).active = true
        textLabel.textAlignment = .Left
        textLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        textLabel.editable = false
        textLabel.dataDetectorTypes = UIDataDetectorTypes.Link
        // If the course is offered this semester
        
        if (course.lectures.count != 0){
            for l in course.lectures{
                let offeringView:OfferingView = OfferingView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width, height: 400))
                offeringView.drawRect(CGRect(x: 0, y: 0, width: StackView.frame.width, height: 400))
                
                let heightConstraint = NSLayoutConstraint(item: offeringView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 400)
                offeringView.addConstraint(heightConstraint)
                
                let widthConstraint = NSLayoutConstraint(item: offeringView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: StackView.frame.width)
                offeringView.addConstraint(widthConstraint)
                
                offeringView.lecture = l

                StackView.addArrangedSubview(offeringView)
                
            }
        }
        
        
        //empty lectures means not offered
        /*if (course.lectures.count != 0)
        {
            for p in course.lectures
            {
                var txt = ""
                
                txt += "Lecture: "
                
                //TODO: ADD PROFFS
                if(p.time.count > 0){
                    
                    for t in p.time{
                        txt += t.day + ", "
                    }
                    txt = String(txt.characters.dropLast())
                    txt = String(txt.characters.dropLast())
                    
                    txt += " " + (p.time.first?.fromTimeText)! + " - " + (p.time.first?.toTimeText)! + "\n"
                    
                }

                
                for t in p.tutorials!
                {
                    txt += "Tutorial: "
                    //TODO: ADD PROFFS
                    if(t.time.count > 0){
                        
                        for td in p.time{
                            txt += td.day + ", "
                        }
                        txt = String(txt.characters.dropLast())
                        txt = String(txt.characters.dropLast())
                        
                        txt += " " + (t.time.first?.fromTimeText)! + " - " + (t.time.first?.toTimeText)! + "\n"
                        
                    }

                }
                
                for l in p.labs!
                {
                    txt += "Lab: "
                    //TODO: ADD PROFFS
                    if(l.time.count > 0){
                        
                        for td in p.time{
                            txt += td.day + ", "
                        }
                        txt = String(txt.characters.dropLast())
                        txt = String(txt.characters.dropLast())
                        
                        txt += " " + (l.time.first?.fromTimeText)! + " - " + (l.time.first?.toTimeText)! + "\n"
                        
                    }
                    
                }
                textLabel.text = txt
                //            textLabel
                StackView.addArrangedSubview(textLabel)
            }
        }*/
        
        
        UIView()
        
        if(course.lectures.count != 0){
            for l in course.lectures
            {
                //StackView.addSubview(<#T##view: UIView##UIView#>)
            }

        }
        
        
        else
        {
            
            //textLabel.numberOfLines = 0
            textLabel.font = UIFont.systemFontOfSize(24, weight: UIFontWeightLight)
            textLabel.heightAnchor.constraintEqualToConstant(300).active = true
            textLabel.textColor = UIColor.lightGrayColor()
            textLabel.text  = "\n\n\n\nCourse Not Offered this Semester\n\n"
            textLabel.textAlignment = .Center
            textLabel.sizeThatFits(textLabel.contentSize)
            textLabel.scrollEnabled = false
            StackView.addArrangedSubview(textLabel)
            

        }
//        if(course.offering != nil){
//            
//            //textLabel.numberOfLines = 0
//
//            var txt = ""
//            for p in (course.offering?.periodics)!
//            {
//                txt += p.type + ": "
//                
//                if(p.profs.count > 0)
//                {
//                    for prof in p.profs{
//
//                        let fillStars = String(count: Int(round(prof.rating)),repeatedValue: Character("★"))
//                        let unfillStars = String(count: 5 - Int(round(prof.rating)),repeatedValue: Character("☆"))
//                        
//                        let ratingText = NSAttributedString(string: prof.fullname + " " + fillStars + unfillStars + "\n",
//                            attributes: [
//                                NSLinkAttributeName: "www.ratemyprofessors.com" + prof.href,
//                            ])
//
//                        
//                        
//                        
//                        txt += prof.fullname + " " + fillStars + unfillStars + "\n"
//                        txt += "RMP : www.ratemyprofessors.com" + prof.href + "\n"
//                        
//                        
//                    }
//                }
////
//                else
//                {
//                        txt += "\n"
//                }
//                
//                
//                
//                if(p.times.count > 0){
//                
//                    for t in p.times{
//                        txt += t.day + ", "
//                    }
//                    txt = String(txt.characters.dropLast())
//                    txt = String(txt.characters.dropLast())
//                    
//                    txt += " " + (p.times.first?.fromTimeText)! + " - " + (p.times.first?.toTimeText)! + "\n"
//                    
//                    txt += "\n"
//                    
//                }
//                
//                
//                
//                
//                
//                
//            }
//            
//            
//            
//            textLabel.text = txt
//            textLabel
//            StackView.addArrangedSubview(textLabel)
//            
//        }
//            
//        // Else the course is not offered this semester
//        else{
//            //textLabel.numberOfLines = 0
//            textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
//            textLabel.heightAnchor.constraintEqualToConstant(300).active = true
//            textLabel.textColor = UIColor.lightGrayColor()
//            textLabel.text  = "\n\n\n\nCourse Not Offered this Semester\n\n"
//            textLabel.textAlignment = .Center
//            textLabel.sizeThatFits(textLabel.contentSize)
//            textLabel.scrollEnabled = false
//            StackView.addArrangedSubview(textLabel)
//
//        }
        
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

