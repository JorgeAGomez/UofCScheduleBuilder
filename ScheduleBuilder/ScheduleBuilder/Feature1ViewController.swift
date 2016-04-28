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
  
    let courses = ["ART 251 - Media Arts: Practice & Theory I","ART 253 - Media Arts: Practice & Theory II","ART 351 - Sonic Arts","CPSC 599 - iOS development"]
    
    
    // ********************************************************************************************************* //
    // this is where we need to add an array for courses instead of the string array above
    // this would need to be done in Feature1ViewController, Feature2ViewController ... Feature5ViewController
    // after a override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) method would be added to
    // pass the course into the coursepage view controller. Similar to how the FavouritesController does it!
    
    //let courses:[Course_new] = [GlobalVariables2.data.courses]
    // ********************************************************************************************************* //

  
    override func viewDidLoad() {
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
    
    cell.textLabel!.text = courses[indexPath.row]
    cell.accessoryType = .DisclosureIndicator
    return cell
  }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
  
    
}
