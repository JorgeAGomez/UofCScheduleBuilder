//
//  SchedulesTableViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class SchedulesTableViewController: UITableViewController {

    var schedules: [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Add some test favoutites
        
        var courses: [Course] = []
        
        //courses.append(GlobalVariables.data.getCourse("CPSC", courseNumber: "481")!)
        
        
        GlobalVariables.data.setFavourite(GlobalVariables.data.getCourse("CPSC", courseNumber: "481")!)
        
        GlobalVariables.data.setFavourite(GlobalVariables.data.getCourse("CPSC", courseNumber: "453")!)
        
        GlobalVariables.data.setFavourite(GlobalVariables.data.getCourse("SENG", courseNumber: "521")!)
        
        GlobalVariables.data.setFavourite(GlobalVariables.data.getCourse("SENG", courseNumber: "511")!)

        
        let favouriteCourses = GlobalVariables.data.getFavourites()
        
        var favoriteOfferings: [Offering] = []
        
        for favorite in favouriteCourses{
            favoriteOfferings.append(favorite.offering!)
        }
        
        let scheduler = Scheduler(offerings: favoriteOfferings)
        
        schedules = scheduler.getSchedules()
        
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
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        
        
        //let schedule = schedules[indexPath.row]
        
        //schedule.courses
        
        cell.scheduleView.drawRect(CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
