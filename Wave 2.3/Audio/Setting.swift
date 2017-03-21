//
//  Setting.swift
//  Audio
//
//  Created by Varun Ballari on 4/16/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class Setting: UIViewController {

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
extension Setting : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Copyright", forIndexPath: indexPath)
            return cell
            
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        } else {
            return 50
        }
    }

    
}


