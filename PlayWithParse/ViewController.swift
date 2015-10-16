//
//  ViewController.swift
//  PlayWithParse
//
//  Created by Vicki Chun on 10/12/15.
//  Copyright © 2015 Vicki Grospe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // seedTestData()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    if (PFUser.currentUser() == nil) {
      // TODO: subclass this view controller for custom logo and text
      let loginViewController = PFLogInViewController()
      loginViewController.delegate = self
      loginViewController.fields = PFLogInFields(rawValue: PFLogInFields.UsernameAndPassword.rawValue
        | PFLogInFields.LogInButton.rawValue
        | PFLogInFields.PasswordForgotten.rawValue
        | PFLogInFields.SignUpButton.rawValue
        | PFLogInFields.Twitter.rawValue)

      loginViewController.emailAsUsername = true
      
      loginViewController.signUpController?.delegate = self
      self.presentViewController(loginViewController, animated: false, completion: nil)
    } else {
      self.performSegueWithIdentifier("loginSegue", sender: self)
    }
  }
  
  //MARK: PFSignInViewControllerDelegate
  func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
    self.dismissViewControllerAnimated(true, completion: nil)
    self.performSegueWithIdentifier("loginSegue", sender: self)
  }
  
  //MARK: PFSignUpViewControllerDelegate
  func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
    self.dismissViewControllerAnimated(true, completion: nil)
    self.performSegueWithIdentifier("loginSegue", sender: self)
  }
  
  
  func seedTestData() {
    let url = NSURL(string: "https://api.parse.com/1/classes/TestClass")
    var request = NSURLRequest(URL: url!)
    let mutableRequest : NSMutableURLRequest = request.mutableCopy() as! NSMutableURLRequest
    
    mutableRequest.addValue("8PyrDwXNuLcoxoX6s9M00AtmBePx8nWfcSw8p3CG", forHTTPHeaderField: "X-Parse-Application-Id")
    mutableRequest.addValue("jsFfajTIVpTMnjWx7LKfdjGYVyX4GqE01KVIjHcU", forHTTPHeaderField: "X-Parse-REST-API-Key")
    mutableRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    mutableRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request = mutableRequest.copy() as! NSURLRequest
    
    let session = NSURLSession(
      configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
      delegate:nil,
      delegateQueue:NSOperationQueue.mainQueue()
    )
    
    let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
      completionHandler: { (dataOrNil, response, error) in
        if let data = dataOrNil {
          if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
            data, options:[]) as? NSDictionary {
              NSLog("response: \(responseDictionary)")
          }
        }
    });
    task.resume()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

