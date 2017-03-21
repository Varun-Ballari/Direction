//
//  NextUpView.swift
//  Audio
//
//  Created by Varun Ballari on 3/24/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit


class NextUpView: UIViewController {
    
    @IBOutlet weak var goback: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func goBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}

