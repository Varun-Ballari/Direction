//
//  SongViewCell.swift
//  Audio
//
//  Created by Varun Ballari on 3/12/16.
//  Copyright © 2016 Archetapp. All rights reserved.
//

import UIKit

class SongViewCell: UITableViewCell { }

extension SongViewCell: UICollectionViewDataSource {

    var song: Song! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet var AlbumArt: UIImageView!
    @IBOutlet var SongTitle: UILabel!
    @IBOutlet var SongDescription: UILabel!
    
    private func updateUI() {
        SongTitle?.text! = song.songTitle
        AlbumArt?.image! = song.albumArt
        SongDescription?.text! = song.songDetails
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.AlbumArt.layer.cornerRadius = 10.0
        self.AlbumArt.clipsToBounds = true
    }
    
}

