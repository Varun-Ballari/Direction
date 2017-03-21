//
//  AllSongs.swift
//  Audio
//
//  Created by Varun Ballari on 3/23/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class AllSongs: UIViewController {
    
    var musicPlayer: SongViewController!
    var songs:[Song]!
    var poa: Int!
    var tbc: TabBarController!
    
    @IBOutlet var PlaylistTable: UITableView!
    @IBOutlet weak var nowPlayingAlbumArt: UIImageView!
    @IBOutlet weak var nowPlayingSongTitle: UILabel!
    @IBOutlet weak var nowPlayingSongDescription: UILabel!
    @IBOutlet weak var nowPlayingImage: UIImageView!
    @IBOutlet weak var exit: UIBarButtonItem!
    
    @IBOutlet weak var segmentedControl2: UISegmentedControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbc = self.tabBarController as! TabBarController
        songs = tbc.songs
        musicPlayer = tbc.musicPlayer

    }
}


extension AllSongs : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return songs.count
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("AllSongsShuffleCell", forIndexPath: indexPath) as! AllSongsShuffleCell
            cell.album1.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.album2.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.album3.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.album4.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.numofSongs.text? = String(songs.count) + " Songs"
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AllSongsTableViewCell", forIndexPath: indexPath) as! AllSongsTableViewCell
            cell.allSongsSongTitle.text? = songs[indexPath.row].title
            cell.allSongsSongDescription.text? = songs[indexPath.row].artist + " - " + songs[indexPath.row].album
            cell.albumArtAllSongs.image? = songs[indexPath.row].albumArt
            cell.time.text? = songs[indexPath.row].time
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            songs.shuffle()
            poa = 0
            
        } else {
            poa = indexPath.row
            musicPlayer.shuffleType = segmentedControl2.selectedSegmentIndex

            if songs[poa] === musicPlayer.currentPlaying { //&& musicPlayer.nowSong.playing {
                tbc.hideTabBar()
                self.tabBarController?.selectedViewController = self.tabBarController!.viewControllers![2]

                musicPlayer.PausePlay.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
                musicPlayer.setInfo(songs[poa])
                return
            }
        }
        
        tbc.insertNowPlaying()
        
        musicPlayer.playlist = songs
        musicPlayer.positionInArray = poa
        musicPlayer.fromClass = 1
        
        musicPlayer.playNewSong(songs[poa])
        
    }
    
    
    @IBAction func changeSegment2(sender: AnyObject) {
        switch segmentedControl2.selectedSegmentIndex {
        case 0:
            self.songs = songs.sort({ $0.title < $1.title })
        case 1:
            self.songs = songs.sort({ $0.album < $1.album })
        case 2:
            self.songs = songs.sort({ $0.artist < $1.artist })
        default:
            break;
        }
        
        self.PlaylistTable.reloadData()
    }
    
}

extension Array {
    /** Randomizes the order of an array's elements. */
    mutating func shuffle() {
        for _ in 0..<10 {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}

