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

class UserProfileViewController: UIViewController {

  @IBOutlet weak var userProfileImage: UIImageView!
  @IBOutlet weak var numberOfFavCourses: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  
  

  //var numberOfFavouriteCourses
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Profile"
    userNameLabel.text = "Jorge Gomez"
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
  


}
