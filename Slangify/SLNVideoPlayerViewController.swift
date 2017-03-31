//
//  SLNVideoPlayerViewController.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 30/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class SLNVideoPlayerViewController : AVPlayerViewController {
    
    @IBOutlet var playButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
    }
    
    
    private func setupVideo() {
        guard let path = Bundle.main.path(forResource: "Selah Sue - This World", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        self.player = player
        self.showsPlaybackControls = false
    }
    
    @IBAction func didTapPlayButton() {
        guard ((self.player) != nil) else {return}
        if (self.player?.isPlaying)! {
            self.player?.pause()
            playButton?.alpha = 1
        }
        else {
            didTapPlayVideo()
            playButton?.alpha = 0
        }
    }
    
    func didTapPlayVideo() {
        guard ((self.player) != nil) else {return}
        self.player?.play()
    }
}


extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
