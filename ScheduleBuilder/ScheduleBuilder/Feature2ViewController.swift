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
  let courses = ["ANTH 303 - Business in cultural context","ECON 201 - Principles of microeconomics","ECON 203 - Principles of macroeconomics"]
  
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
