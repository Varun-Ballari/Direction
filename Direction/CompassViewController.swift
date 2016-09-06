//
//  ViewController.swift
//  Direction
//
//  Created by Varun Ballari on 3/3/16.
//  Copyright © 2016 Varun Ballari. All rights reserved.
//

import UIKit
import CoreLocation
import AudioToolbox

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var compass: UIImageView!
    @IBOutlet weak var num: UILabel!
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //print(newHeading.magneticHeading)
        
        var degrees:Double = newHeading.magneticHeading as! Double
        var turnVal:Double = degrees * M_PI/180.0
        
        compass.transform = CGAffineTransformMakeRotation(CGFloat(-turnVal))
        num.text = String(Int(degrees)) + "°";
        
        if ((355 <= degrees &&  degrees <= 360) || (0 <= degrees && degrees <= 5)){
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

