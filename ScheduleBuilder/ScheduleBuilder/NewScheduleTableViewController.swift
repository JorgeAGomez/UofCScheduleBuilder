//
//  NewScheduleTableViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2016-01-31.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class NewScheduleTableViewController: UITableViewController {

    //var schedules: [Schedule] = []
    
    var schedules_new: [[Periodic_new]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let favouriteCourses2 = GlobalVariables2.data.getFavourites()
        let scheduleBuilder = ScheduleBuilder(favoritedCourses: favouriteCourses2, NUMBER_OF_SCHEDULES: 4)
        scheduleBuilder.createValidSchedules()
        schedules_new = scheduleBuilder.validSchedules // [[Periodic_new]]
        
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        let favouriteCourses2 = GlobalVariables2.data.getFavourites()
        let scheduleBuilder = ScheduleBuilder(favoritedCourses: favouriteCourses2, NUMBER_OF_SCHEDULES: 4)
        scheduleBuilder.createValidSchedules()
        schedules_new = scheduleBuilder.validSchedules //TODO: THIS IS SO WRONG ON SO MANY LEVELS! CACHE THIS SHIT PLEASE
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
        
        return schedules_new.count + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        
        if(indexPath == NSIndexPath(forRow: 0, inSection: 0)){
            
            // Send that schedule's courses to the schedule view
            cell.scheduleView.isBlank = true;
            
            // Draw the schedule view
            cell.scheduleView.drawRect(CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        }
        
        else{
            // Pick a particular schedule
            let schedule = schedules_new[indexPath.row - 1]
        
            // Send that schedule's courses to the schedule view
            cell.scheduleView.isBlank = false;
            cell.scheduleView.schedule = schedule
            cell.scheduleView.drawRect(CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        }
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectTemplate"{
            let scheduleBuilderController = segue.destinationViewController as! ScheduleBuilderViewController
            
            if let selectedCourseCell = sender as? ScheduleTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedCourseCell)!
                
                if indexPath.row == 0{
                }
                else{
                    let selectedSchedule = schedules_new[indexPath.row-1]         // MAYBE back to -1
                    scheduleBuilderController.schedule_new = selectedSchedule
                    //scheduleBuilderController.scheduleView.schedule = scheduleBuilderController.schedule
                }
                
                
            }
            
        }
    }
    

}
