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

let API_URL = "https://aqueous-brushlands-9148.herokuapp.com"


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
    var firstName: String?
    var lastName: String?
    
    func registerCompletion(completion: () -> Void) {
    
        var info =  [
        
            "method" : "POST",
            "endpoint" : "/users/register",
            "parameters" : [
                
               "username": username!,
                "email" : email!,
                "password" : password!,
                "first_name" : firstName!,
                "last_name" : lastName!
            ]
        
        ] as [String:AnyObject]
    
        
        println(info)
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("Register Completion Response 1: \(responseInfo)")
            
            if let accessToken = responseInfo?["access_token"] as? String {
            
                self.token = accessToken
                
                completion()
            
            }
            
        })
        
        completion()
    
    }
    
    func login(completion: () -> Void) {
        
        var info =  [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "username": username!,
                "password" : password!
            ]
            
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("Login Completion Response 2: \(responseInfo)")
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
        completion()
        
    }
    
    func postImage() {
        
        var info =  [
            
            "method" : "POST",
            "endpoint" : "/posts/",
            "parameters" : [
                
                "username": username!,
                "email" : email!
            ]
            
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            
            
        })
    
    }
    
    
    func requestWithInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: [String:AnyObject]?) ->Void)?) {
        
        println("Inside RailsRequest 1")
        
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
