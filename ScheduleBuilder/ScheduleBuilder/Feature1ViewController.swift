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
    
  
    
}
