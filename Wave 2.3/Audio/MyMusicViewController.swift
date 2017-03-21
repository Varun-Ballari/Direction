//
//  MyMusicViewController.swift
//  Audio
//
//  Created by Varun Ballari on 3/12/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class MyMusicViewController: UIViewController {
    
    var musicPlayer: SongViewController!
    var songs: [Song]!
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var AllSongs: UITableView!
    
    var selectedPlaylistName: String!
    var selectedPlaylist: [Song]!
    
    struct songsAlbum {
        var sectionName : String!
        var sectionObjects : [Song]!
    
    }
    
    var songsAlbumArray = [songsAlbum]()
    var dictionary = [String:[Song]]()
    
    override func viewDidLoad() {

        let tbc = tabBarController as! TabBarController
        songs = tbc.songs
        musicPlayer = tbc.musicPlayer
        super.viewDidLoad()
        
        for s:Song in songs {
            if dictionary.keys.contains(s.grouping) {
                let tempArray = dictionary[s.grouping]!.append(s)
            } else {
                dictionary[s.grouping] = [s]
            }
        }
        
        let stringArray = Array(dictionary.keys.map { String($0) }).sort({ $0 < $1 })
        for item in stringArray {
            songsAlbumArray.append(songsAlbum(sectionName: item, sectionObjects: dictionary[item]))
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! PlaylistsView
        destViewController.playlistName = selectedPlaylistName
        destViewController.songs = selectedPlaylist
        destViewController.musicPlayer = musicPlayer
    }
}


extension MyMusicViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 + songsAlbumArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("discover", forIndexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecentlyAddedTVCell", forIndexPath: indexPath) as! RecentlyAdded
            cell.playlistRow = songsAlbumArray[indexPath.section - 1].sectionObjects
            cell.sectionTitle.text = songsAlbumArray[indexPath.section - 1].sectionName
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 220
        } else {
            return 220
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section > 0 {
            selectedPlaylist = songsAlbumArray[indexPath.section - 1].sectionObjects
            selectedPlaylistName = songsAlbumArray[indexPath.section - 1].sectionName
            
            self.performSegueWithIdentifier("passInfo", sender: self)
        }
    }
}



