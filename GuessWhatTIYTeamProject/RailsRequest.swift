//
//  RailsRequest.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/18/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

private let defaults = NSUserDefaults.standardUserDefaults()
private let _singleton = RailsRequest()

let API_URL = "http://tiyqpic.herokuapp.com"


class RailsRequest: NSObject {
    
    //Singleton Class
    class func session() -> RailsRequest { return _singleton }
   
    var token: String? {
    
        get {
        
            return defaults.objectForKey("TOKEN") as? String
        }
        
        set {
        
            defaults.setValue(newValue, forKey: "TOKEN")
            defaults.synchronize()
        
        }
    
    }
    
    var username: String?
    var email: String?
    var password: String?
    
    func registerCompletion(completion: () -> Void) {
    
        var info =  [
        
            "method" : "POST",
            "endPoint" : "/users/register",
            "parameters" : [
                
               "username": username!,
                "email" : email!,
                "password" : password!
            ]
        
        ] as [String:AnyObject]
    
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            if let accessToken = responseInfo?["access_token"] as? String {
            
                self.token = accessToken
                
                completion()
            
            }
            
        })
    
    }
    
    func login() {
    }
    
    func postImage() {
    
    }
    
    func requestWithInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: [String:AnyObject]?) ->Void)?) {
        
        let endpoint = info["endpoint"] as! String
        if let url = NSURL(string: API_URL + endpoint) {
        
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info["method"] as! String
            
            if let token = token {
            
                request.setValue(token, forHTTPHeaderField: "Authorization")
            
            }
            
            ////BODY
            
            let bodyInfo = info["parameters"] as! [String:AnyObject]
            
            let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
            
            let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
            
            let postLength = "\(jsonString!.length)"
            
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            
            let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPBody = postData
            
            /////Body
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject]{
                
                    completion?(responseInfo: json)
                    
                }
                
            })
        
        
        }
    
    }
    
}
