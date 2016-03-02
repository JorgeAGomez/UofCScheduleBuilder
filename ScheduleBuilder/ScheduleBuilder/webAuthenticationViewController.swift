//
//  webAuthenticationViewController.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-02-27.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit
import WebKit

class webAuthenticationViewController: UIViewController, UIWebViewDelegate {

  let webURL = Constants.authenticationURL
  var session = NSURLSession.sharedSession()
  
  // MARK: IBAction
  @IBAction func cancelButton(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: IBOulet
  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      webView.delegate = self
      self.title = "User Authentication"
      let request = NSURLRequest(URL : webURL!)
      webView.loadRequest(request)
    
    
        // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
  
  
}
