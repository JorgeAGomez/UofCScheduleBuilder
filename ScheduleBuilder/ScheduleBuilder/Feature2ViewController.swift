//
//  Feature2ViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

// Photoshop, 

import UIKit

class Feature2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  // POPULAR COURSES //
  //let courses = ["ANTH 303 - Business in cultural context","ECON 201 - Principles of microeconomics","ECON 203 - Principles of macroeconomics"]
    
    
    let featuredCourses:[Array<String>] = [["DRAM","203"],["DRAM","205"],["MUSI","351"],["ECON","203"],["ANTH","303"],["FILM","201"],["MKTG","341"],["TOUR","309"],["ENGL","388"],["PHIL","279"],["DRAM","571"],["MUHL","309"],["JPNS","205"],["COMS","363"]]
    
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
        if segue.identifier == "feature2detail"{
            let courseViewController = segue.destinationViewController as! CourseViewController
            
            if let selectedFavouritesCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPathForCell(selectedFavouritesCell)!
                let selectedFeature = courses[indexPath.row]
                courseViewController.course = selectedFeature
            }
        }
        
    }

}
