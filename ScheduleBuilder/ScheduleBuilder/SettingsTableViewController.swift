//
//  SettingsTableViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

var rowContent = []

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.tableFooterView = UIView()

        self.title = "Settings"
        
        let semester = "Fall 2015"
        let major = "Computer Science"
        let minor = "Art"
        let masters = "Masters"
        
        rowContent = ["Semester: " + semester, "Major: " + major,"Minor: " + minor,masters]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowContent.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.row != rowContent.count - 1){
        
            let cell = tableView.dequeueReusableCellWithIdentifier("detailsCell", forIndexPath: indexPath) as! SettingsDetailsCell
            
            cell.cellLabel?.text = rowContent[indexPath.row] as? String
            
        
            return cell
    
        }
        
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! SettingsSwitchTableViewCell
          
              cell.cellLabel!.text = rowContent[indexPath.row] as? String
          
            return cell
        }
    }

}
