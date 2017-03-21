//
//  Model.swift
//  Audio
//
//  Created by Varun Ballari on 3/12/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class Song {
    var url: String
    var albumArt: UIImage
    var title: String
    var artist: String
    var album: String
    var albumArtist: String
    var grouping: String
    var genre: String
    var year: Int
    var trackNumber: Int
    var trackCount: Int
    var timeSec: Int
    var time: String
    var dateAdded: String

    
    init(url: String, albumArt: UIImage, title: String, artist: String, album: String, albumArtist: String, grouping: String, genre: String, year: Int, trackNumber: Int, trackCount: Int, timeSec: Int, time: String, dateAdded: String) {
        
        self.url = url
        self.albumArt = albumArt
        self.title = title
        self.artist = artist
        self.album = album
        self.albumArtist = albumArtist
        self.grouping = grouping
        self.genre = genre
        self.year = year
        self.trackNumber = trackNumber
        self.trackCount = trackCount
        self.timeSec = timeSec
        self.time = time
        self.dateAdded = dateAdded
        

    }

    static func createSongs(location:String) -> [Song] {
        let allSongs = readXML(location)
        return allSongs
    }
    
    static func readXML(path: String) -> [Song]! {
        
        var songArray:[Song] = []
        
        do {
            let wordList = NSDictionary(contentsOfFile: path)
            let tracks: NSDictionary = wordList!.objectForKey("Tracks") as! NSDictionary
            let trackKeys = tracks.allKeys as! [String]
            
            for key in trackKeys {
                let subDict = tracks[key]
                
                var Url: String
                //var AlbumArt: UIImage
                var Title: String
                var Artist: String
                var Album: String
                var AlbumArtist: String
                var Grouping: String
                var Genre: String
                var Year: Int
                var TrackNumber: Int
                var TrackCount: Int
                var TimeSec: Int
                var Time: String
                var DateAdded: String //__NSTaggedDate
                
                //print(key)
                    
                if let temp = subDict!.objectForKey("Name") {
                    Title = temp as! String
                } else {
                    Title = "No Name"
                }

                if let temp = subDict!.objectForKey("Artist") {
                    Artist = temp as! String
                } else {
                    Artist = "No Artist"
                }
                
                if let temp = subDict!.objectForKey("Album") {
                    Album = temp as! String
                } else {
                    Album = "No Album"
                }
                
                if let temp = subDict!.objectForKey("Album Artist") {
                    AlbumArtist = temp as! String
                } else {
                    AlbumArtist = "No Album Artist"
                    
                }
                
                if let temp = subDict!.objectForKey("Grouping") {
                    Grouping = temp as! String
                } else {
                    Grouping = "No Grouping"
                }
                
                if let temp = subDict!.objectForKey("Genre") {
                    Genre = temp as! String
                } else {
                    Genre = "No Genre"
                }
                
                if let temp = subDict!.objectForKey("Year") {
                    Year = temp as! Int
                } else {
                    Year = 0
                }

                if let temp = subDict!.objectForKey("Track Number") {
                    TrackNumber = temp as! Int
                } else {
                    TrackNumber = 0
                }
                
                if let temp = subDict!.objectForKey("Track Count") {
                    TrackCount = temp as! Int
                } else {
                    TrackCount = 0
                }
                if let temp = subDict!.objectForKey("Total Time") {
                    TimeSec = temp as! Int
                } else {
                    TimeSec = 0
                }
                
                let (eh, em, es) = secondsToHoursMinutesSeconds(TimeSec/1000)
                if eh == 0 {
                    if em < 10 {
                        Time = String(format: "%01d:%02d", em, es)
                    } else {
                        Time = String(format: "%02d:%02d", em, es)
                    }
                    
                } else {
                    if eh < 10 {
                        Time = String(format: "%01d:%02d:%02d", eh, em, es)
                    } else {
                        Time = String(format: "%01d:%02d:%02d", eh, em, es)
                    }
                }
                

                
//                if let temp = subDict!.objectForKey("Date Added") {
//                    DateAdded = temp as! __NSTaggedDate
//                } else {
//                    DateAdded =
//                }
            
                DateAdded = ""
                
                Url = subDict!.objectForKey("Location") as! String
                if Url.containsString("&#38;") {
                    Url = Url.stringByReplacingOccurrencesOfString("&#38;", withString: "&", options: NSStringCompareOptions.LiteralSearch, range: nil)
                }
                
                let AlbumArt = getAlbumArt(Url) //UIImage(named: "default Album Art")!
            
                let newSong = Song(url: Url, albumArt: AlbumArt, title: Title, artist: Artist, album: Album, albumArtist: AlbumArtist, grouping: Grouping, genre: Genre, year: Year, trackNumber: TrackNumber, trackCount: TrackCount, timeSec: TimeSec, time: Time, dateAdded: DateAdded)
            
                songArray.append(newSong)
                
            }
            songArray = songArray.sort({ $0.title < $1.title })
            return songArray
                
        } catch {
            print("Unable to read file: \(path)");
            return nil
        }
    }
    


    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (Int(seconds) / 3600, (Int(seconds) % 3600) / 60, (Int(seconds % 3600) % 60))
    }
    
    static func getAlbumArt(url: String) -> UIImage {
        let fileUrl = NSURL(string: url)
        var albumArt: UIImage = UIImage(named:"default Album Art")!
        let asset = AVAsset(URL: fileUrl!) as AVAsset
        for metaDataItems in asset.commonMetadata {
            
            if metaDataItems.commonKey == "artwork" {
                let imageData = metaDataItems.value as! NSData
                let image1: UIImage = UIImage(data: imageData)!
                albumArt = image1
                
            } else {
                continue
            }
        }

        return albumArt
    }
}
