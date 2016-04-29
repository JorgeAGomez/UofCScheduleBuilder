//
//  Feature1ViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class Feature1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  // DESIGN COURSES //

    // Featured Courses
    let featuredCourses:[Array<String>] = [["ART","251"],["ART","253"],["MUSI","351"],["CPSC","599"],["ART","334"],["ART","311"],["ART","503"],["CPSC","583"],["ART","313"],["ART","315"],["ART","317"],["ART","321"],["ART","331"],["ART","336"]]
    
    var courses:[Course_new] = []
  
    override func viewDidLoad() {
        
        for feat in featuredCourses{
            if(GlobalVariables2.data.getCourse(feat[0], num: feat[1]) != nil){
                courses.append(GlobalVariables2.data.getCourse(feat[0], num: feat[1])!)
            }
        }
        
        
        super.viewDidLoad()

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
        if segue.identifier == "feature1detail"{
            let courseViewController = segue.destinationViewController as! CourseViewController
            
            if let selectedFavouritesCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPathForCell(selectedFavouritesCell)!
                let selectedFeature = courses[indexPath.row]
                courseViewController.course = selectedFeature
            }
        }
        
    }
    
  
    
}
