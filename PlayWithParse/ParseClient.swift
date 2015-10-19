//
//  ParseClient.swift
//  PlayWithParse
//
//  Created by Vicki Chun on 10/12/15.
//  Copyright © 2015 Vicki Grospe. All rights reserved.
//

import UIKit

let parseBaseURL = NSURL(string: "https://api.parse.com/1/")

class ParseClient {
  static let instance = ParseClient()
  
  func getCurrentUser() {
    
    
  }
  /*func getTestName(params: NSDictionary?, completion: (name: [String]?, error: NSError?) -> ()) {
      var request = NSMutableURLRequest()
      request.HTTPMethod = "GET"
      request.addValue(appId, forHTTPHeaderField: "X-Parse-Application-Id")
      request.addValue(restAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      
      var error: NSError?
      var paramsJSON = NSJSONSerialization.dataWithJSONObject(params!, options: nil)
      var paramsJSONString = NSString(data: paramsJSON!, encoding: NSUTF8StringEncoding)
      var whereClause = paramsJSONString?.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)
      
      let urlString = "\(baseURL)/1/classes/TestClass"
      var requestURL = NSURL(string: String(format: "%@?%@%@", urlString, "where=", whereClause!))
      
      request.URL = requestURL!
      
      var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, err) -> Void in
        var stringData = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(stringData)
      })
      
      task.resume()
    }
  
  }*/

/*func saveAudio() {
  PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
  
  //get the audio in NSData format
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Memo" ofType:@"m4a"];
  NSData *audioData = [NSData dataWithContentsOfFile:filePath];
  NSLog(@"audioData = %@", audioData);
  
  //create audiofile as a property
  PFFile *audioFile = [PFFile fileWithName:@"Memo.m4a" data:audioData];
  testObject[@"audioFile"] = audioFile;
  
  //save
  [testObject saveInBackground];
}*/


}