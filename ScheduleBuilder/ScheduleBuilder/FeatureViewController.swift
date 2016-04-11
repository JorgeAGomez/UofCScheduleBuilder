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
      let viewController2 = self.storyboard?.instantiateViewControllerWithIdentifier("Feature2") as! Feature2ViewController
      let viewController3 = self.storyboard?.instantiateViewControllerWithIdentifier("Feature3") as! Feature3ViewController
      let viewController4 = self.storyboard?.instantiateViewControllerWithIdentifier("Feature4") as! Feature4ViewController
      let viewController5 = self.storyboard?.instantiateViewControllerWithIdentifier("Feature5") as! Feature5ViewController
    
      viewController1.title = "Design"
      viewController2.title = "Popular"
      viewController3.title = "No Pre-Req"
      viewController4.title = "Coding"
      viewController5.title = "No final"
    
      let viewControllers = [viewController1, viewController2, viewController3, viewController4, viewController5]
    
      options.menuHeight = 35
      options.menuItemMode = .Underline(height: 2.0, color: UIColor.redColor(), horizontalPadding: 0.1, verticalPadding: 0.1)
    
      let pagingMenuController = self.childViewControllers.first as! PagingMenuController
      options.menuDisplayMode = .Infinite(widthMode: .Flexible)
      pagingMenuController.setup(viewControllers: viewControllers, options: options)
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
