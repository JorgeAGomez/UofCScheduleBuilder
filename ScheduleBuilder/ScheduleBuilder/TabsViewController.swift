//
//  TabsViewController.swift
//  ScheduleBuilder
//
//  Created by Tiffany on 2015-12-02.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self;
    }
    
}
