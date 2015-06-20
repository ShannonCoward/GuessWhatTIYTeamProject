//
//  GameHomeViewController.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/19/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

class GameHomeViewController: UIViewController {

    
    
    @IBAction func playGameButton(sender: UIButton) {
        // Optional, play the game screen
        
    }
    
    
    @IBAction func creatAPhotoButon(sender: UIButton) {
        
        let getCameraVC = storyboard?.instantiateViewControllerWithIdentifier("getCameraVC") as! CameraViewController
        
        self.navigationController?.pushViewController(getCameraVC, animated: true)
    
    }
    
    
    
    @IBAction func leaderBoardButton(sender: UIButton) {
        // Optional, leader board screen
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
