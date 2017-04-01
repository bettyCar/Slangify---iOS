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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // background color
        GradientColorDispatcher.setGradient(toView: self.view)
    }
}

extension SLNVideoViewController {
    
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SLNWatchVideoViewController
        destination.phrase = phrase
        if let path = Bundle.main.path(forResource: "Selah Sue - This World", ofType:"mp4") {
            destination.videoURL = URL(fileURLWithPath: path)
        }
    }
}
