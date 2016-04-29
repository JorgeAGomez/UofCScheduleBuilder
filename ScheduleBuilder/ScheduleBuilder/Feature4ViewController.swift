//
//  Feature4ViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class Feature4ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  //VIDEO GAMES COURSES//
  
   //let courses = ["ART 311 - History of video games","CPSC 453 - Computer Graphics","CPSC 585 - Games programming"]
  
    
    let featuredCourses:[Array<String>] = [["ART","311"],["CPSC","453"],["CPSC","585"],["CPSC","599"],["MUSI","402"],["ART","315"],["ART","503"],["ART","251"],["MUSI","351"],["ART","231"],["ART","233"],["CPSC","217"],["CPSC","598"],["MUSI","451"]]
    
    var courses:[Course_new] = []
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for feat in featuredCourses{
            if(GlobalVariables2.data.getCourse(feat[0], num: feat[1]) != nil){
                courses.append(GlobalVariables2.data.getCourse(feat[0], num: feat[1])!)
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
       func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return courses.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    cell.textLabel!.text = courses[indexPath.row].getName() + "  " + courses[indexPath.row].title
    cell.accessoryType = .DisclosureIndicator
    return cell
  }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "feature4detail"{
            let courseViewController = segue.destinationViewController as! CourseViewController
            
            if let selectedFavouritesCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPathForCell(selectedFavouritesCell)!
                let selectedFeature = courses[indexPath.row]
                courseViewController.course = selectedFeature
            }
        }
        
    }
    
}
