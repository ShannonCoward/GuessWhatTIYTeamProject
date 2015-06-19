//
//  LoginViewController.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/17/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
  
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func submitButton(sender: AnyObject) {
        submitButtonPressed()
    }

    @IBAction func goBackFromLogin(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
            
    }
        
    func submitButtonPressed() {
            
        RailsRequest.session().username = usernameTextField!.text
        RailsRequest.session().password = passwordTextField!.text
        
        RailsRequest.session().login { () -> Void in
            
            self.goBackToStartScreen()
        
        }
    }
    
    func goBackToStartScreen() {
        
        println("go back to start screen")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
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
