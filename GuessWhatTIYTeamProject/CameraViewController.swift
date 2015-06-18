//
//  CameraViewController.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/17/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit
//import MobileCoreServices
import AFNetworking
import AFAmazonS3Manager



class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController = UIImagePickerController()
    
    
    @IBAction func takePicture(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            
            dispatch_after(DISPATCH_TIME_NOW + NSEC_PER_SEC * 20, dispatch_get_main_queue()) { () -> Void in
                
                
                self.presentViewController(self.imagePickerController, animated: true, completion: nil)
                
            }
            
            imagePickerController.mediaTypes = [kUTTypeImage]
            imagePickerController.allowsEditing = true
            self.presentViewController(imagePickerController, animated: true, completion: nil)
            
        } else {
            
            
            println("No Camera.")
            
        }
        
        
        
        
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var picker = UIImagePickerController()
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            saveImageToS3(image)
            
        }
        
        
        picker.dismissViewControllerAnimated (true, completion:nil)
        
    }
    
//    var bucketName = ""
//    var bucketRegion = ""
    
//    let amazonS3Manager = AmazonS3RequestManager(bucket: "BucketName",
//        region: .USStandard,
//        accessKey: "",
//        secret: "")
    
    let s3Manager = AFAmazonS3Manager(accessKeyID: "", secret: "")
    
    
    
    func saveImageToS3(image: UIImage){
        
        let timestamp = NSDate().timeIntervalSince1970
        
        let imageName = "myImage_\(timestamp)"
        
        let imageData = UIImagePNGRepresentation(image)
        
        //         amazonS3Manager.putObject(imageData, destinationPath: imageName + ".png", acl: nil)
        
        if let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as? String {
            
            let filePath = documentPath.stringByAppendingPathComponent(imageName + ".png")
            
            println(filePath)
            
            imageData.writeToFile(filePath, atomically: false)
            let fileURL = NSURL(fileURLWithPath: filePath)
            
//            amazonS3Manager.putObject(fileURL!, destinationPath: imageName + ".png", acl: AmazonS3PredefinedACL.Public)
            
            s3Manager.postObjectWithFile(filePath, destinationPath: imageName + ".png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                
                let percentageWritten = (CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)) * 100.0
                
                    println("upladed \(percentageWritten)%")
                
            }, success: { (responseObject) -> Void in
                
                    println("\(responseObject)")
                
            }, failure: { (error) -> Void in
                
                    println("\(error)")
            })
            
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
