//
//  Feature3ViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class Feature3ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  
  //ONLINE COURSES //
  
  //let courses = ["COMS 363 - Professional and Technical Communication"]
    
    
    let featuredCourses:[Array<String>] = [["COMS","363"],["BIOL","371"],["EDUC","420"],["GRST","211"],["RELS","200"],["RELS","203"],["RELS","205"],["SOWK","300"],["EDUC","450"],["EDUC","456"],["IPHE","503"],["RELS","201"],["SOWK","302"],["SOWK","304"]]
    
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
        if segue.identifier == "feature3detail"{
            let courseViewController = segue.destinationViewController as! CourseViewController
            
            if let selectedFavouritesCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPathForCell(selectedFavouritesCell)!
                let selectedFeature = courses[indexPath.row]
                courseViewController.course = selectedFeature
            }
        }
        
    }

}
