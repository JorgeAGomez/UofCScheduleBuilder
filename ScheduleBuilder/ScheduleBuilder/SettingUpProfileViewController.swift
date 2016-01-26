//
//  SettingUpProfileViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-21.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit
import CoreData

class SettingUpProfileViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var loginNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @NSManaged var username: String
  @NSManaged var password: String
  
  override func viewDidLoad() {
      super.viewDidLoad()
      loginNameTextField.delegate = self
      passwordTextField.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func loginButton(sender: AnyObject) {
    //store login and password
    
  }
}
