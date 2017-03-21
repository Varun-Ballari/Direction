//
//  TabBarController.swift
//  Audio
//
//  Created by Varun Ballari on 3/23/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var file: String!
    var songs:[Song]!
    var musicPlayer: SongViewController!
    var selectedSong: Song!
    
    override func viewDidLoad() {
        self.delegate = self

        super.viewDidLoad()

        //self.delegate = self
        songs = Song.createSongs(file)
        musicPlayer = storyboard!.instantiateViewControllerWithIdentifier("MusicPlayer") as! SongViewController
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if tabBar.selectedItem!.title == "Now Playing" {
            hideTabBar()
        }
    }
    
    func hideTabBar() {
        UIView.animateWithDuration(0.3) {
            self.tabBar.frame = CGRectOffset(self.tabBar.frame, 0, self.tabBar.frame.size.height)
            return
        }
        
        self.musicPlayer.hidesBottomBarWhenPushed = true
        self.tabBar.hidden = true
        
        UIView.animateWithDuration(0.3) {
            self.musicPlayer.view.layoutIfNeeded()
        }
    }
    
    func insertNowPlaying() {
        var tabBarController2 = self.viewControllers
        
        if (tabBarController2![2] != musicPlayer) {
            tabBarController2?.insert(musicPlayer, atIndex: 2)
            let item3 = UITabBarItem(title: "Now Playing", image: UIImage.gifWithName("animated"), tag: 3)
            musicPlayer.tabBarItem = item3
            self.setViewControllers(tabBarController2, animated: true)
        
        }
    }
    
    func exitNowPlaying() {
        self.tabBar.hidden = false
        UIView.animateWithDuration(0.3) {
            self.tabBar.frame = CGRectOffset(self.tabBar.frame, 0, -self.tabBar.frame.size.height)
            return
        }
        
        tabBar.hidden = false
    }

}

