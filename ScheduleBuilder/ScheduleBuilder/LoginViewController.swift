//
//  SettingUpProfileViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-21.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {

  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "Login"
  }
  
  override func viewWillAppear(animated: Bool) {
    self.tabBarController?.hidesBottomBarWhenPushed = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func loginButton(sender: AnyObject) {
    //store login and password
    
  }
}
