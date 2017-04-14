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
import FLKAutoLayout

class SLNVideoPlayerViewController : AVPlayerViewController {
    
    let playButton : UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        return button
    }()
    
    fileprivate var videoURL : URL
    
    init(videoURL : URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
    }
    
    
    private func setupVideo() {
        let player = AVPlayer(url: videoURL)
        self.player = player
        self.showsPlaybackControls = false
        self.view.addSubview(playButton)
        playButton.align(toView: self.view)
        playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
    }
    
    @IBAction func didTapPlayButton() {
        guard let player = self.player else {return}
        if player.isPlaying {
            player.pause()
            playButton.setTitle("Play", for: .normal)
        }
        else {
            didTapPlayVideo()
            playButton.setTitle("", for: .normal)
        }
    }
    
    func didTapPlayVideo() {
        guard let player = self.player else {return}
        player.play()
    }
}


extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
