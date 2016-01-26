//
//  FeatureViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-22.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController {

  @IBOutlet weak var courseList2: UIImageView!
  @IBOutlet weak var courseList1: UIImageView!
  @IBOutlet weak var courseList6: UIImageView!
  @IBOutlet weak var courseList5: UIImageView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "Features"

        // Do any additional setup after loading the view.
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
