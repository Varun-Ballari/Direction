//
//  SongViewController.swift
//  Audio
//
//  Created by Varun Ballari on 3/11/16.
//  Copyright © 2016 Ballari Productions. All rights reserved.
//


import UIKit
import AVFoundation
import MediaPlayer

class SongViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    //passed in INFO
    var playlist: [Song]!
    var positionInArray:Int!
    var shuffleType: Int!
    var fromClass: Int!
    
    
    //current Playing Song Info
    var currentPlaying: Song!
    var nowSong: AVAudioPlayer = AVAudioPlayer()
    
    
    //Buttons & View Infor
    @IBOutlet var mediaPlayer: UIView!
    
    @IBOutlet var SongName: UILabel!
    @IBOutlet var SongInfo: UILabel!
    @IBOutlet var Albumart: UIImageView!
    @IBOutlet var imageflip: UIImageView!
    
    @IBOutlet var SongPosition: UISlider!
    @IBOutlet weak var timeEnd: UILabel!
    @IBOutlet weak var timeStart: UILabel!
    @IBOutlet var Volume: UISlider!

    @IBOutlet var PausePlay: UIButton!
    @IBOutlet var Rewind: UIButton!
    @IBOutlet var Forward:UIButton!
    
    @IBOutlet var viewAlbum: UIButton!
    @IBOutlet var shuffle: UIButton!
    @IBOutlet var love: UIButton!
    @IBOutlet var replay: UIButton!
    @IBOutlet var viewPlaylist: UIButton!
    
//--------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInfo(currentPlaying)

        SongPosition.setThumbImage(UIImage(named:"redBar"), forState: UIControlState.Normal)
        SongPosition.setThumbImage(UIImage(named:"redBar"), forState: UIControlState.Selected)
        SongPosition.setMaximumTrackImage(UIImage(named:"whiteBar"), forState: UIControlState.Normal)
        SongPosition.setMaximumTrackImage(UIImage(named:"grayBar"), forState: UIControlState.Normal)
        Volume.setThumbImage(UIImage(named: "volumeSmall"), forState: UIControlState.Normal)
        Volume.setThumbImage(UIImage(named: "volumeSmall"), forState: UIControlState.Selected)
        
        
        SongPosition.maximumValue = Float(nowSong.duration)
        timeEnd.text = String(nowSong.duration - nowSong.currentTime)
        timeStart.text = String(nowSong.currentTime)
        
        nowSong.volume = Volume.value
        
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(SongViewController.updateSlider), userInfo: nil, repeats: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func PausePlay(sender: AnyObject) {
        if (nowSong.playing == true){
            nowSong.stop()
            PausePlay.setImage(UIImage(named:"play"), forState: UIControlState.Normal)
        } else{
            nowSong.play()
            PausePlay.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
        }
    }
    
    func playNewSong(s: Song) {
        self.currentPlaying = s
        let fileLocation: String = s.url
        let file = NSURL(string: fileLocation)
        do {
            nowSong = try AVAudioPlayer(contentsOfURL: file!)
            nowSong.prepareToPlay()
            nowSong.delegate = self
            nowSong.volume = 0.5
            nowSong.play()
        } catch {
            print("This is an Error")
        }
    }
    
    func setInfo(s: Song) {
        SongName.text = s.title
        SongInfo.text = s.artist + " - " + s.album
        Albumart.image = s.albumArt
        imageflip.image = s.albumArt
    }
    
    func stopSong() {
        nowSong.stop()
    }
    
    
    @IBAction func BackOneSong(sender: AnyObject) {
        
        var temp1 = 0
        if (nowSong.playing == true){
            temp1 = 1
        }
        
        if positionInArray > 0 {
            
            positionInArray = positionInArray - 1
            playNewSong(playlist[positionInArray])
        }
        if temp1 == 1 {
            nowSong.play()
        }
        setInfo(playlist[positionInArray])
    }
    
    @IBAction func SkipTrack(sender: AnyObject) {
        
        //print(positionInArray)
        var temp2 = 0
        if (nowSong.playing == true){
            temp2 = 1
        }
        
        if positionInArray < playlist.count - 1 {
            positionInArray = positionInArray + 1
            playNewSong(playlist[positionInArray])
        }
        
        if temp2 == 1 {
            nowSong.play()
        }
        
        setInfo(playlist[positionInArray])
        currentPlaying = playlist[positionInArray]
    }
    
    @IBAction func PositionOfSong(sender: AnyObject) {
        nowSong.stop()
        nowSong.currentTime = NSTimeInterval(SongPosition.value)
        nowSong.prepareToPlay()
        nowSong.play()
    }
    
    func updateSlider(){
        SongPosition.maximumValue = Float(nowSong.duration)
        SongPosition!.value = Float(nowSong.currentTime)
        
        let (eh, em, es) = secondsToHoursMinutesSeconds(nowSong.duration - nowSong.currentTime)
        let (sh, sm, ss) = secondsToHoursMinutesSeconds(nowSong.currentTime)
        
        if eh == 0 || sh == 0{
            if em < 10 {
                timeEnd.text = String(format: "%01d:%02d", em, es)
                timeStart.text = String(format: "%01d:%02d", sm, ss)
            } else {
                timeEnd.text = String(format: "%02d:%02d", em, es)
                timeStart.text = String(format: "%02d:%02d", sm, ss)
            }
            
        } else {
            if eh < 10 {
                timeEnd.text = String(format: "%01d:%02d:%02d", eh, em, es)
                timeStart.text = String(format: "%02d:%02d:%02d", sh, sm, ss)
            } else {
                timeEnd.text = String(format: "%01d:%02d:%02d", eh, em, es)
                timeStart.text = String(format: "%02d:%02d:%02d", sh, sm, ss)
            }
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Double) -> (Int, Int, Int) {
        return (Int(seconds) / 3600, (Int(seconds) % 3600) / 60, (Int(seconds % 3600) % 60))
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if positionInArray < playlist.count - 1 {
            positionInArray = positionInArray + 1
            playNewSong(playlist[positionInArray])
            setInfo(playlist[positionInArray])
        }
    }
    
    @IBAction func VolumeControl(sender: AnyObject) {
        nowSong.volume = Volume.value   
    }
    
    @IBAction func LoveSong(sender: AnyObject) {
        if love.currentImage!.isEqual(UIImage(named:"heart")) {
            love.setImage(UIImage(named:"redheart"), forState: UIControlState.Normal)
        } else {
            love.setImage(UIImage(named:"heart"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func shuffle(sender: AnyObject) {
        if shuffle.currentImage!.isEqual(UIImage(named:"shuffle")) {
            shuffle.setImage(UIImage(named:"shuffleBlack"), forState: UIControlState.Normal)
            
            if shuffleType == 0 {
                playlist = playlist.sort({ $0.title < $1.title })
            } else if shuffleType == 1 {
                playlist = playlist.sort({ $0.album < $1.album })
            } else if shuffleType == 2{
                playlist = playlist.sort({ $0.artist < $1.artist })
            } else {
                print("None")
            }
            
            if let index = playlist.indexOf({ $0.title == currentPlaying.title} ) {
                positionInArray = index
            }
            
            //print(positionInArray)
            
        } else {
            shuffle.setImage(UIImage(named:"shuffle"), forState: UIControlState.Normal)
            playlist.shuffle()
            positionInArray = 0
        }
    }
    
    @IBAction func replay(sender: AnyObject) {
        if replay.currentImage!.isEqual(UIImage(named:"repeat")) {
            replay.setImage(UIImage(named:"repeatBlack"), forState: UIControlState.Normal)
        } else {
            replay.setImage(UIImage(named:"repeat"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func viewAlbum(sender: AnyObject) {
        
        
//        if viewAlbum.currentImage!.isEqual(UIImage(named:"album")) {
//            viewAlbum.setImage(UIImage(named:"albumBlack"), forState: UIControlState.Normal)
//        } else {
//            viewAlbum.setImage(UIImage(named:"album"), forState: UIControlState.Normal)
//        }
    }
    
    @IBAction func viewPlaylist(sender: AnyObject) {
        
//        var nextUpView = storyboard!.instantiateViewControllerWithIdentifier("NextUpView") as! NextUpView
//        self.presentViewController(nextUpView, animated: true, completion: nil)
        
        //self.performSegueWithIdentifier("idFirstSegue", sender: self)
        
//        if viewPlaylist.currentImage!.isEqual(UIImage(named:"playlist")) {
//            viewPlaylist.setImage(UIImage(named:"playlistBlack"), forState: UIControlState.Normal)
//        } else {
//            viewPlaylist.setImage(UIImage(named:"playlist"), forState: UIControlState.Normal)
//        }
    }

    @IBAction func exitToPlaylist(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.tabBarController?.selectedViewController = self.tabBarController!.viewControllers![fromClass]
        let temp = self.tabBarController as! TabBarController
        temp.exitNowPlaying()

        

    }


}

