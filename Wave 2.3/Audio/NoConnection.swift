//
//  NoConnection.swift
//  Audio
//
//  Created by Varun Ballari on 4/17/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class NoConnection: UIViewController {
    
    @IBOutlet weak var back: UIBarButtonItem!
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = UIImage.gifWithName("no-connection")
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
    @IBAction func backPressed(segue: UIStoryboardSegue) {
        self.performSegueWithIdentifier("backPressed", sender: self)
    }
    
}
