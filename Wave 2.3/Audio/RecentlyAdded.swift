//
//  RecentlyAdded.swift
//  Audio
//
//  Created by Varun Ballari on 3/18/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import Foundation
import UIKit

class RecentlyAdded: UITableViewCell {
    var playlistRow:[Song]!
    @IBOutlet weak var RAollectionView: UICollectionView!
    @IBOutlet weak var sectionTitle: UILabel!
}

extension RecentlyAdded: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlistRow.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecentlyAddedSong", forIndexPath: indexPath) as! RASong
        
        cell.SongTitle.text = playlistRow[indexPath.row].title
        cell.SongDescription.text = playlistRow[indexPath.row].artist + " - " + playlistRow[indexPath.row].album
        cell.AlbumArt.image = playlistRow[indexPath.row].albumArt
        
        return cell
    }
}
