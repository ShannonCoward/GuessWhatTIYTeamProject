//
//  ViewController.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/17/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        self.navigationController?.navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.hidden = true
        
        checkIfLoggedIn()
        
    }

    func checkIfLoggedIn() {
        
        if RailsRequest.session().token != nil {
            
            // present guess controller
            
        }
        
    }

}

