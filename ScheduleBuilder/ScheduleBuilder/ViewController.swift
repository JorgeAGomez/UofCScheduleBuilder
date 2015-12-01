//
//  ViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2015-10-30.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Change the tab bar to the official U of C Color
        MainTabBar.appearance().tintColor = UIColor(hue: 355/360, saturation: 0.92, brightness: 0.87, alpha: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

