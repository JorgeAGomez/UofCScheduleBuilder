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
        
        
        // use dynamic cells
        //tableView.estimatedRowHeight = 200
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        
        // Add some test favoutites
        
        //var courses: [Course] = []
        
        //courses.append(GlobalVariables.data.getCourse("CPSC", courseNumber: "481")!)
        
//        GlobalVariables.data.getCourse("CPSC", courseNumber: "481")?.favourited = true
//        GlobalVariables.data.getCourse("CPSC", courseNumber: "453")?.favourited = true
//        GlobalVariables.data.getCourse("SENG", courseNumber: "521")?.favourited = true
//        GlobalVariables.data.getCourse("SENG", courseNumber: "511")?.favourited = true
        
        let favouriteCourses = GlobalVariables.data.getFavourites()
        
        var favoriteOfferings: [Offering] = []
        
        for favorite in favouriteCourses{
            if(favorite.offering != nil){
                favoriteOfferings.append(favorite.offering!)
            }
        }
        
        let scheduler = Scheduler(offerings: favoriteOfferings)
        
        schedules = scheduler.getSchedules()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let favouriteCourses = GlobalVariables.data.getFavourites()
        
        var favoriteOfferings: [Offering] = []
        
        for favorite in favouriteCourses{
            if(favorite.offering != nil){
                favoriteOfferings.append(favorite.offering!)
            }
        }
        
        let scheduler = Scheduler(offerings: favoriteOfferings)
        
        schedules = scheduler.getSchedules()
        tableView.reloadData()
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
        return schedules.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        
        // Pick a particular schedule
        let schedule = schedules[indexPath.row]
        
//        cell.scheduleView = ScheduleView()
        // Send that schedule's courses to the schedule view
        cell.scheduleView.schedule = schedule
        cell.scheduleView.events = schedule.events
        
        // Draw the schedule view
        cell.scheduleView.drawRect(CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "scheduleDetails"{
            let scheduleDetailsController = segue.destinationViewController as! ScheduleDetailsViewController
            
            if let selectedCourseCell = sender as? ScheduleTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedCourseCell)!
                let selectedSchedule = schedules[indexPath.row]
                scheduleDetailsController.schedule = selectedSchedule
            }
            
        }
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
