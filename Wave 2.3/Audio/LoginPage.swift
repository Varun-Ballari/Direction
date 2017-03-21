//
//  LoginPage.swift
//  Audio
//
//  Created by Varun Ballari on 4/9/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class LoginPage: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationText.delegate = self
        loginScrollView.delegate = self
        
        let view1: LoginScreen1 = LoginScreen1(nibName: "LoginScreen1", bundle: nil)
        let view2: LoginScreen2 = LoginScreen2(nibName: "LoginScreen3", bundle: nil)
        let view3: LoginScreen3 = LoginScreen3(nibName: "LoginScreen2", bundle: nil)
        
        self.addChildViewController(view1)
        self.loginScrollView.addSubview(view1.view)
        view1.didMoveToParentViewController(self)
        
        self.addChildViewController(view2)
        self.loginScrollView.addSubview(view2.view)
        view2.didMoveToParentViewController(self)
        
        self.addChildViewController(view3)
        self.loginScrollView.addSubview(view3.view)
        view3.didMoveToParentViewController(self)
        
        var V2Frame : CGRect = view1.view.frame
        V2Frame.origin.x = self.view.frame.width
        view2.view.frame = V2Frame
        
        var V3Frame : CGRect = view3.view.frame
        V3Frame.origin.x = 2 * self.view.frame.width
        view3.view.frame = V3Frame
    
        self.loginScrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.size.height)
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pageController.currentPage = Int(x/w)
    }


    
//    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
//        if !(locationText.text!.isEmpty) {
//            if (locationText.text?.rangeOfString("/iTunes/iTunes Music Library.xml") != nil) {
//                return true
//            } else {
//                let alert = UIAlertView()
//                alert.title = "Not Valid"
//                alert.message = "Please Enter A Valid iTunes XML File Location. Ex. '/Users/varunballari/Music/iTunes/iTunes Music Library.xml'"
//                alert.addButtonWithTitle("Ok")
//                alert.show()
//                return false
//            }
//            
//        } else {
//            let alert = UIAlertView()
//            alert.title = "No Text"
//            alert.message = "Please Enter Text In The Box"
//            alert.addButtonWithTitle("Ok")
//            alert.show()
//            return false
//        }
//        
//        return false
//    }

    func isValid() -> Bool {
        if !(locationText.text!.isEmpty) {
            if (locationText.text?.rangeOfString("/iTunes/iTunes Music Library.xml") != nil) {
                return true
            } else {
                let alert = UIAlertView()
                alert.title = "Not Valid"
                alert.message = "Please Enter A Valid iTunes XML File Location. Ex. '/Users/varunballari/Music/iTunes/iTunes Music Library.xml'"
                alert.addButtonWithTitle("Ok")
                alert.show()
                return false
            }
            
        } else {
            let alert = UIAlertView()
            alert.title = "No Text"
            alert.message = "Please Enter Text In The Box"
            alert.addButtonWithTitle("Ok")
            alert.show()
            return false
        }
        
        return false

    }
    
    @IBAction func load(sender: AnyObject) {
//        if !locationText.text!.isEmpty {
//            if let locationEmpty = locationText.text?.rangeOfString("/iTunes/iTunes Music Library.xml") {
        
        if (isValid()) {
            if let wordList = NSDictionary(contentsOfFile: locationText.text!) {
                self.performSegueWithIdentifier("load", sender: self)
            } else {
                self.performSegueWithIdentifier("didNotLoad", sender: self)
            }
        }

    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "load" {
            let destViewController = segue.destinationViewController as! TabBarController
            destViewController.file = locationText.text!
        } else {
            
            print("Not Working")
        }
    }


}
