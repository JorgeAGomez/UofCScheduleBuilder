//
//  SettingsDepartmentsTableViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2016-04-11.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class SettingsDepartmentsTableViewController: UITableViewController {

    var departments = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        departments = GlobalVariables2.data.departments
        
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
        return departments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("departmentCell", forIndexPath: indexPath)

        cell.textLabel?.text = departments[indexPath.row]
        
        // Configure the cell...

        return cell
    }
    
    
    var selectedCell:SettingsDepartmentCell!

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? SettingsDepartmentCell{
            
            if selectedCell != nil{
                
                if cell == selectedCell{
                    cell.accessoryType = .None
                }
                    
                else{
                    selectedCell.accessoryType = .None
                    cell.accessoryType = .Checkmark
                    selectedCell = cell
                }
            }
                
            else{
                cell.accessoryType = .Checkmark
                selectedCell = cell
            }
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
        if let settingsTableViewController = segue.destinationViewController as? SettingsTableViewController{
            
            //settingsTableViewController.rowContent[0] = "Semester: " + selectedCell.textLabel!.text!
            
        }
        
    }
 

}
