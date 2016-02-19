//
//  FavouritesController.swift
//  ScheduleBuilder
//
//  Created by Tiffany on 2015-12-01.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import CoreData
import UIKit

class FavouritesController: UITableViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var nofavs: UILabel!
    var favourites = [Course_new]()
    var favourite_classes : [FavouriteCourses]!
    var fetchResultController:NSFetchedResultsController!
    var dh = DataHandler()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourites"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //Uncomment next line to add Edit button
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
        let fetchRequest = NSFetchRequest(entityName: "Favourite")
        let sortDescriptor = NSSortDescriptor(key: "coursename", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                favourites = fetchResultController.fetchedObjects as! [Course_new]
            } catch {
                print(error)
            }
        }
        self.favourites = GlobalVariables2.data.getFavourites()
    }
    
    override func viewWillAppear(animated: Bool) {
        favourites = GlobalVariables2.data.getFavourites()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

    // MARK: - Table view data source

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (favourites.count == 0){
            nofavs.hidden = false;
        }
        else{
            nofavs.hidden = true;
        }

        return favourites.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favouriteCell", forIndexPath: indexPath) as! FavouritesTableCell
  
      
      //let favourite_course = FavouriteCourses(
        // Configure the cell...
        cell.textLabel?.text =  favourites[indexPath.row].courseNumber + "   " + favourites[indexPath.row].title
      
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "FavouriteDetailSelection"{
            let courseViewController = segue.destinationViewController as! CourseViewController
            
            if let selectedFavouritesCell = sender as? FavouritesTableCell{
                let indexPath = tableView.indexPathForCell(selectedFavouritesCell)!
                let selectedFavourite = favourites[indexPath.row]
                courseViewController.course = selectedFavourite
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
