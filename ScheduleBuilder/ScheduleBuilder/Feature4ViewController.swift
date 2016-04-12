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
  
   let courses = ["311 History of video games","453 Computer Graphics","585 Games programming"]
  
  
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
    
    cell.textLabel!.text = courses[indexPath.row] as? String
    return cell
  }

}
