//
//  ViewController.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/17/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextFieldDelegate {
    
    
    
//    @IBOutlet weak var photoBeingSent: UIImageView!
    
    // Correct answer text fields
    @IBOutlet weak var correctAnswerField: UITextField!
    
    // Dummy answer text fields
    @IBOutlet weak var dummyAnswerField1: UITextField!
    @IBOutlet weak var dummyAnswerField2: UITextField!
    @IBOutlet weak var dummyAnswerField3: UITextField!
    
    @IBAction func sendPhotoButton(sender: UIButton) {
        // Send Answers! button
        
        RailsRequest.session().answer = correctAnswerField.text
        RailsRequest.session().answer_1 = dummyAnswerField1.text
        RailsRequest.session().answer_2 = dummyAnswerField2.text
        RailsRequest.session().answer_3 = dummyAnswerField3.text
        
        RailsRequest.session().createPost { () -> Void in
            
            println(self.navigationController?.viewControllers)
            
            let gameHomeReferenceVC = self.navigationController?.viewControllers[2] as! GameHomeViewController
            self.navigationController?.popToViewController(gameHomeReferenceVC, animated: true)
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctAnswerField.delegate = self
        dummyAnswerField1.delegate = self
        dummyAnswerField2.delegate = self
        dummyAnswerField3.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
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
