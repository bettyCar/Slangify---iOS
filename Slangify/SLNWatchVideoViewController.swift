//
//  SLNWatchVideoViewController.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 30/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit
import FLKAutoLayout

class SLNWatchVideoViewController : UIViewController {
    
    fileprivate let margin : Int = 10
    
    fileprivate var videoController : SLNVideoPlayerViewController!
    fileprivate var translationView : SLNTranslationView = SLNTranslationView()
    fileprivate var shareBar : UIView = {
        let view = UIView()
        view.backgroundColor = HexColors.purple.getColor()
        return view
    }()
    fileprivate let shareButton : UIButton = {
        let button = UIButton()
        button.setTitle("share", for: .normal)
        return button
    }()
    
    internal var phrase : Phrase!
    internal var videoURL : URL!
    
    init(phrase: Phrase, videoURL: URL) {
        self.phrase = phrase
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        translationView = SLNTranslationView(phrase: phrase)
        videoController = SLNVideoPlayerViewController(videoURL: videoURL)
        super.viewDidLoad()
        setup()
    }
    
}

fileprivate extension SLNWatchVideoViewController {
    
    func setup() {
        // background color
        GradientColorDispatcher.setGradient(toView: self.view)
        // add views
        self.addChildViewController(videoController)
        self.view.addSubview(videoController.view)
        self.view.addSubview(translationView)
        self.view.addSubview(shareBar)
        
        videoController.view.alignTopEdge(withView: self.view, predicate: String(0))
        videoController.view.alignLeading(String(0), trailing: String(0), toView: self.view)
        videoController.view.alignAttribute(NSLayoutAttribute.height, to: NSLayoutAttribute.width, ofView: self.view, predicate: String(0))
        
        shareBar.alignLeading(String(0), trailing: String(0), toView: self.view)
        shareBar.constrainHeight(String(45))
        shareBar.constrainTopSpace(toView: videoController.view, predicate: String(0))
        shareBar.addSubview(shareButton)
        shareButton.alignTop(String(0), bottom: String(0), toView: shareBar)
        shareButton.alignTrailingEdge(withView: shareBar, predicate: String(-margin))
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        
        translationView.alignBottomEdge(withView: self.view, predicate: String(-margin))
        translationView.alignLeading(String(margin), trailing: String(-margin), toView: self.view)
        translationView.constrainTopSpace(toView: shareBar, predicate: String(margin))
    }
    
    @objc func didTapShare() {
        let shareController = UIActivityViewController.init(activityItems: [videoURL], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = self.view
        self.present(shareController, animated: true, completion: nil)
    }
}
