//
//  SLNVideoViewController.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 11/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class SLNVideoViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var phrase : Phrase?
    fileprivate let uploader = SLNStorageUploader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        setupView()
        // background color
        GradientColorDispatcher.setGradient(toView: self.view)
    }
}

extension SLNVideoViewController {
    
    func showAlert() {
        let alert = SLNInfoModalView(firstText: "The sentence will appear for 5 seconds", secondText: "Give it your best shot")
        self.view.addSubview(alert)
        let margin = 25
        alert.alignLeading(String(margin), trailing: String(-margin), toView: self.view)
        let hidden = alert.constrainBottomSpace(toView: self.view, predicate: String(0))
        let center = alert.alignCenterY(withView: self.view, predicate: String(0))
        center.isActive = false
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            center.isActive = true
            hidden.isActive = false
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }) { (finished) in
            UIView.animate(withDuration: 0.3, delay: 4, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: {
                center.isActive = false
                hidden.isActive = true
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    // Camera Layout with sentence 
    
    func setupView() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeVideo as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            
//            let imagePicker = UIImagePickerController()
//            
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            
//            self.present(imagePicker, animated: true, completion: nil)
//        }
        if let path = Bundle.main.path(forResource: "SelahSue-ThisWorld", ofType:"mp4") {
            uploader.uploadVideo(videoPath: path, languageName: "", phrase: phrase!, userId: "")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SLNWatchVideoViewController
        destination.phrase = phrase
//        let url = "https://www.youtube.com/watch?v=Uxkd6Wp5fWM"
//        destination.videoURL = URL(string: url)
        if let path = Bundle.main.path(forResource: "SelahSue-ThisWorld", ofType:"mp4") {
            destination.videoURL = URL(fileURLWithPath: path)
        }
        
    }
}
