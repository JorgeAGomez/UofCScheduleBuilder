//
//  SettingUpProfileViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-21.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var backgroungImageView: UIImageView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "Login"
      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.alpha = 0.6
      blurEffectView.frame = view.bounds
      backgroungImageView.addSubview(blurEffectView)
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
