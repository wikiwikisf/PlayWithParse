//
//  ParseViewController.swift
//  PlayWithParse
//
//  Created by Vicki Chun on 10/18/15.
//  Copyright © 2015 Vicki Grospe. All rights reserved.
//

import UIKit

class ParseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    seedRecordingData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func getData(requestPath: String) {
    let baseUrl = "https://api.parse.come/1/"
    let url = NSURL(string: "\(baseUrl)\(requestPath)")
    var request = NSURLRequest(URL: url!)
    let mutableRequest : NSMutableURLRequest = request.mutableCopy() as! NSMutableURLRequest
    
    // TODO: replace with keys in credentials file
    //mutableRequest.addValue("8PyrDwXNuLcoxoX6s9M00AtmBePx8nWfcSw8p3CG", forHTTPHeaderField: "X-Parse-Application-Id")
    //mutableRequest.addValue("jsFfajTIVpTMnjWx7LKfdjGYVyX4GqE01KVIjHcU", forHTTPHeaderField: "X-Parse-REST-API-Key")

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
  
  private func seedRecordingData() {
    let currentUser = PFUser.currentUser()
    
    print("seed recording data")
    let recording = PFObject(className: "Recordings")
    recording["title"] = "Kids Tap 3"
    recording["originator"] = currentUser
    recording["replays"] = 0
    recording["type"] = "Original"
    recording.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      self.setRecordingForUser(recording)
     // self.setTagForRecording(recording)

      // TODO: replace with a valid user email/id
      let query = PFUser.query()!.whereKey("username", matchesRegex: "melophonic@gmail.com")
      query.getFirstObjectInBackgroundWithBlock({ (user: PFObject?, error: NSError?) -> Void in
        if let user = user as? PFUser {
          self.likeRecording(recording, user: user)
        }
      })
      
    }
  }
  
  private func setTagForRecording(recording: PFObject)  {
    print("create tag for recording")
    let tag = PFObject(className: "Tags")
    tag["name"] = "needsPiano"
    tag["recordings"] = [recording]
    tag.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
        // create pointer to tag from recording
        recording.addUniqueObjectsFromArray([tag], forKey: "tags")
        recording.saveInBackground()
    }
    
  }
  
  private func likeRecording(recording: PFObject, user: PFUser) {
    print("like the recording")
    let like = PFObject(className: "Likes")
    like["recordingId"] = recording.objectId
    like.addUniqueObjectsFromArray([user], forKey: "users")
    like.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      // create a pointer to the liker from the recording
      recording.addUniqueObjectsFromArray([like], forKey: "likers")
      recording.saveInBackground()
    }
  }
  
  private func setRecordingForUser(recording: PFObject) {
    let userQuery = PFUser.query()
    
    do {
      let currentUser =  try userQuery!.getObjectWithId(PFUser.currentUser()!.objectId!)
      currentUser.addUniqueObjectsFromArray([recording], forKey: "recordings")
      currentUser.saveInBackground()
    } catch {
      print("error getting current user")
    }
    
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
