//
//  CameraViewController.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/17/15.
//   Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit
import AmazonS3RequestManager
import AFNetworking
import AFAmazonS3Manager


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        dispatch_after(DISPATCH_TIME_NOW + NSEC_PER_MSEC * 5, dispatch_get_main_queue()) { () -> Void in
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let newImage = RBResizeImage(image, CGSizeMake(400, 550))
            
//            var imageManipulation = ImageManipulation()
//            let newImage = imageManipulation.imageResizeTo(imagePhoto, size: CGSizeMake(170, 250))
//
//            picker.dismissViewControllerAnimated(true, completion: nil)

            picker.dismissViewControllerAnimated(true, completion: { () -> Void in
                
                self.saveImageToS3(newImage)
                
                var postVC = self.storyboard?.instantiateViewControllerWithIdentifier("PostVC") as! PostViewController
                
                self.navigationController?.pushViewController(postVC, animated: true)
            })
            
//            var postVC = storyboard?.instantiateViewControllerWithIdentifier("PostVC") as! PostViewController
            
//            println(picker.navigationController?.viewControllers)
//            println("Another test \(self.navigationController?.viewControllers)")
            
//            self.navigationController?.pushViewController(postVC, animated: true)
            
//            saveImageToS3(newImage)
            
        }

        
    }
    
    
    
    //    let amazonS3Manager = AmazonS3RequestManager(bucket: "",
    //        region: .USStandard,
    //        accessKey: "",
    //        secret: "")
    
  
    
    let s3Manager = AFAmazonS3Manager(accessKeyID: accessKey, secret: secret)
    
    
    func saveImageToS3(image: UIImage) {
        
        s3Manager.requestSerializer.bucket = bucket
        s3Manager.requestSerializer.region = AFAmazonS3USStandardRegion
        
        let timestamp = Int(NSDate().timeIntervalSince1970)
        
        let imageName = "myImage_\(timestamp)"
        
        let resizedImage = UIImage()
        
        
        let imageData = UIImagePNGRepresentation(image)
        
        println(image)
        
        //        amazonS3Manager.putObject(imageData, destinationPath: imageName + ".png", acl: nil)
        
        
        if let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as? String {
            
            let filePath = documentPath.stringByAppendingPathComponent(imageName + ".png")
            
            println(filePath)
            
            
            
            
            
            imageData.writeToFile(filePath, atomically: false)
            
            let fileURL = NSURL(fileURLWithPath: filePath)
            
            //            amazonS3Manager.putObject(fileURL!, destinationPath: imageName + ".png", acl: AmazonS3PredefinedACL.Public)
            
            s3Manager.putObjectWithFile(filePath, destinationPath: imageName + ".png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                
                
                let percentageWritten = (CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)) * 100.0
                
                println("Uploaded \(percentageWritten)%")
                
                
                }, success: { (responseObject) -> Void in
                    
                    let info = responseObject as! AFAmazonS3ResponseObject
                    
                    
                    println("\(info.URL)")
                    
                    RailsRequest.session().image = "\(info.URL)"
                    
                }, failure: { (error) -> Void in
                    
                    println("\(error)")
                    
            })
            
        }
        
    }
    
}