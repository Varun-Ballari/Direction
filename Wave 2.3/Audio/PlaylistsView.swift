//
//  PlaylistsView.swift
//  Audio
//
//  Created by Varun Ballari on 3/19/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class PlaylistsView: UIViewController {
    
    var musicPlayer: SongViewController!
    var songs:[Song]!
    var playlistName: String!
    var poa: Int!
    
    var tbc: TabBarController!

    @IBOutlet var PlaylistTable: UITableView!
    @IBOutlet weak var nowPlayingAlbumArt: UIImageView!
    @IBOutlet weak var nowPlayingSongTitle: UILabel!
    @IBOutlet weak var nowPlayingSongDescription: UILabel!
    @IBOutlet weak var nowPlayingImage: UIImageView!
    @IBOutlet weak var exit: UIBarButtonItem!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbc = self.tabBarController as! TabBarController

    }
    
    @IBAction func exit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


extension PlaylistsView : UITableViewDataSource, UITableViewDelegate {
    
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
            let cell = tableView.dequeueReusableCellWithIdentifier("mainPlaylistCell", forIndexPath: indexPath) as! PlaylistShuffleViewCell
            
            cell.playlistalbum1.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.playlistalbum2.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.playlistalbum3.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.playlistalbum4.image? = songs[Int(arc4random_uniform(UInt32(songs.count)))].albumArt
            cell.playlistnumofSongs.text? = String(songs.count) + " Songs"
            cell.playlistname.text? = playlistName
            return cell

        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("allSongsCell", forIndexPath: indexPath) as! PlaylistSongViewCell
        
            cell.AllSongsSongTitle.text = songs[indexPath.row].title
            cell.AllSongsSongDescription.text = songs[indexPath.row].artist + " - " + songs[indexPath.row].album
            cell.AlbumArtAllSongs.image = songs[indexPath.row].albumArt
            cell.Time.text = songs[indexPath.row].time
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
            musicPlayer.shuffleType = segmentedControl.selectedSegmentIndex
            
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
        musicPlayer.fromClass = 0
        
        musicPlayer.playNewSong(songs[poa])
    }
    
    @IBAction func changeSegment(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
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

