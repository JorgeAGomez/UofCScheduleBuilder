//
//  UserProfileViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-21.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class UserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  //MARK: IBOutlets
  @IBOutlet weak var userProfileImage: UIImageView!
  @IBOutlet weak var numberOfFavCourses: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  
  
  //MARK: Variables
  var info = ["School: University of Calgary","Major: Computer Science","Concentration: Human Computer Interaction","Minor: Business"]
  

  //var numberOfFavouriteCourses
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Profile"
    userNameLabel.text = "Student Name"
  }
  
  override func viewDidAppear(animated: Bool) {
    let favourites = GlobalVariables2.data.getFavourites()
    numberOfFavCourses.text = String(favourites.count)
    numberOfFavCourses.reloadInputViews()
    userProfileImage.layer.cornerRadius = 65.0
    userProfileImage.clipsToBounds = true
  }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return info.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UserProfileTableViewCell
    
    cell.textLabel!.text = info[indexPath.row]
    return cell
  }


}
