//
//  FeatureViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-22.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit
import PagingMenuController

class FeatureViewController: UIViewController {

  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "Features"
    
      let options = PagingMenuOptions()
      options.selectedFont = UIFont(name: "American Typewriter", size: 20)!
    
      let viewController1 = self.storyboard?.instantiateViewControllerWithIdentifier("Feature1") as! Feature1ViewController
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
