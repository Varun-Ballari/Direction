//
//  File.swift
//  Audio
//
//  Created by Varun Ballari on 3/12/16.
//  Copyright © 2016 Archetapp. All rights reserved.
//

import UIKit
import Foundation


class allSongs
{
    // MARK: - Public API
    var songTitle = ""
    var songDetails = ""
    var numberOfMembers = 0
    var numberOfPosts = 0
    var albumArt: UIImage!
    
    init(songTitle: String, songDetails: String, albumArt: UIImage!)
    {
        self.songTitle = songTitle
        self.songDetails = songDetails
        self.albumArt = albumArt
        numberOfMembers = 1
        numberOfPosts = 1
    }
    
    // MARK: - Private
    // dummy data
    static func createSongs() -> [Song]
    {
        return [
            Song(songTitle: "World", songDetails: "adventures!", albumArt: UIImage(named: "p2")!),
            Song(songTitle: "Stories", songDetails: "stories.", albumArt: UIImage(named: "p3")!),
            Song(songTitle: "iOS Dev", songDetails: "beautiful.", albumArt: UIImage(named: "p4")!),
            Song(songTitle: "Race", songDetails: "boats and sky.", albumArt: UIImage(named: "p5")!),
            Song(songTitle: "Personal", songDetails: "presence.", albumArt: UIImage(named: "p6")!),
            Song(songTitle: "News", songDetails: "breaking-news.", albumArt: UIImage(named: "p7")!),
        ]
    }
}
