//
//  RegisterViewController.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/17/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func submitRegisterButton(sender: AnyObject) {
        submitButtonPressed()
    }

    @IBAction func goBackFromRegistration(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        usernameTextField.delegate = self
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func submitButtonPressed() {
        
        println("Hello")
        
        RailsRequest.session().username = usernameTextField.text
        RailsRequest.session().email = emailTextField.text
        RailsRequest.session().firstName = firstNameTextField.text
        RailsRequest.session().lastName = lastNameTextField.text
        RailsRequest.session().password = passwordTextField.text
        
        println(RailsRequest.session().username)
        println(usernameTextField.text)
    
        
        RailsRequest.session().registerCompletion { () -> Void in
            
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
