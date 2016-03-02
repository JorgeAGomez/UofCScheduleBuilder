//
//  DepartmentsTableViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class DepartmentsTableViewController: UITableViewController, UISearchResultsUpdating {

    var allDepartments = [String]()
    var filteredDepartments = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        allDepartments = GlobalVariables2.data.departments
        
        filteredDepartments = allDepartments
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.tintColor = UIColor.redColor()
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.definesPresentationContext = true
        
        //let navbar = self.navigationController?.navigationBar
        //let navcolor = navbar!.barTintColor
        //let navsize = navbar!.frame
        
        //navbar?.clipsToBounds
        //navbar!.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        //navbar!.shadowImage = UIImage()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredDepartments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("departmentCell", forIndexPath: indexPath) as! DepartmentTableViewCell

        // Configure the cell...
        
        cell.textLabel?.text = filteredDepartments[indexPath.row]

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController. 
        // Pass the selected object to the new view controller.
        if segue.identifier == "DepartmentSelection"{
            let courseViewController = segue.destinationViewController as! DeptartmentTableViewController
            
            if let selectedDepartmentCell = sender as? DepartmentTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedDepartmentCell)!
                let selectedDepartment = filteredDepartments[indexPath.row]
                courseViewController.department = selectedDepartment
            }
            
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        // if search bar is active, filter results based on search bar text
        if(self.resultSearchController.active){
            let searchBarStr = searchController.searchBar.text!.lowercaseString
            
            if(searchBarStr == ""){
                filteredDepartments = allDepartments
            }
            else{
                filteredDepartments = allDepartments.filter({$0.lowercaseString.containsString(searchBarStr) == true })
            }
        }
            //otherwise, put back all departments
        else{
            filteredDepartments = allDepartments
        }
        
        self.tableView.reloadData()
    }
    
    
    
    // stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
        
        
       /* if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }*/



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
