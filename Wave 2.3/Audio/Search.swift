//
//  Search.swift
//  Audio
//
//  Created by Varun Ballari on 4/17/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit

class Search: UIViewController {

    var musicPlayer: SongViewController!
    var songs:[Song]!
    var poa: Int!
    var tbc: TabBarController!
    
    
    var filteredSongs: [Song]!

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbc = self.tabBarController as! TabBarController
        songs = tbc.songs
        musicPlayer = tbc.musicPlayer
        
        filteredSongs = songs

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension Search : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredSongs?.count ?? 0
        } else {
            return self.songs?.count ?? 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.searchTableView!.dequeueReusableCellWithIdentifier("searchCell") as! SearchCell
        
        cell.searchTitle.text? = self.filteredSongs![indexPath.row].title
        cell.searchDescription.text? = self.filteredSongs![indexPath.row].artist + " - " + self.filteredSongs![indexPath.row].album
        cell.searchImage.image? = self.filteredSongs![indexPath.row].albumArt
        cell.searchTime.text? = self.filteredSongs![indexPath.row].time
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        poa = indexPath.row
        
        if self.filteredSongs[poa] === musicPlayer.currentPlaying {
            tbc.hideTabBar()
            self.tabBarController?.selectedViewController = self.tabBarController!.viewControllers![2]
                
            musicPlayer.PausePlay.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
            musicPlayer.setInfo(self.filteredSongs[poa])
            return
        }

        
        tbc.insertNowPlaying()
        
        musicPlayer.playlist = self.filteredSongs
        musicPlayer.positionInArray = poa
        musicPlayer.fromClass = 3
        musicPlayer.playNewSong(self.filteredSongs[poa])
        
    }
    
    func filterContentForSearchText(searchText: String) {
        
        self.filteredSongs = songs!.filter({(temp: Song) -> Bool in

            return temp.title.lowercaseString.rangeOfString(searchText.lowercaseString) != nil || temp.artist.lowercaseString.rangeOfString(searchText.lowercaseString) != nil || temp.album.lowercaseString.rangeOfString(searchText.lowercaseString) != nil || temp.albumArtist.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
            
        })
    }

    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
}

