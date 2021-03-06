//
//  SchedulesTableViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class SchedulesTableViewController: UITableViewController {
    
    // Will contain all schedules for the selected courses
    var schedules_new: [[Periodic_new]] = []
    
    var savedSchedules: [[Periodic_new]] = []
    
    @IBAction func cancelSchedule(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveSchedule(segue:UIStoryboardSegue) {
        
    }
    
    
    @IBOutlet weak var noschedules: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // use dynamic cells
        //tableView.estimatedRowHeight = 200
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        
        //let favouriteCourses2 = GlobalVariables2.data.getFavourites()
        //let scheduleBuilder = ScheduleBuilder(favoritedCourses: favouriteCourses2, NUMBER_OF_SCHEDULES: 4)
        //scheduleBuilder.createValidSchedules()
        //schedules_new = scheduleBuilder.validSchedules // [[Periodic_new]]
        
        
    }
    override func viewWillAppear(animated: Bool)
    {
        //let favouriteCourses2 = GlobalVariables2.data.getFavourites()
        //let scheduleBuilder = ScheduleBuilder(favoritedCourses: favouriteCourses2, NUMBER_OF_SCHEDULES: 4)
        //scheduleBuilder.createValidSchedules()
        //schedules_new = scheduleBuilder.validSchedules //TODO: THIS IS SO WRONG ON SO MANY LEVELS! CACHE THIS SHIT PLEASE
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        if (savedSchedules.count == 0){
            noschedules.hidden = false;
        }
        else
        {
            noschedules.hidden = true;
        }
        return savedSchedules.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        
        // Pick a particular schedule
        let schedule = savedSchedules[indexPath.row]
        
        cell.scheduleView.isBlank = false;
        cell.scheduleView.schedule = schedule
        cell.scheduleView.drawRect(CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // User has chosen a schedule and now wants to see details
        if segue.identifier == "scheduleDetails"
        {
            let scheduleDetailsController = segue.destinationViewController as! ScheduleDetailsViewController
            
            if let selectedCourseCell = sender as? ScheduleTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedCourseCell)!
                let selectedSchedule = savedSchedules[indexPath.row]
                scheduleDetailsController.schedule = selectedSchedule
            }
            
        }

        
    }
    
    
}
