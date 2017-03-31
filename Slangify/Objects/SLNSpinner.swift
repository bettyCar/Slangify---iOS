//
//  SLNSpinner.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 23/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit

class SLNSpinner : NSObject {
    
    let spinner : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let untouchableView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    func showSpinner(_ view : UIView) {
        guard !spinner.isAnimating else {
            return
        }
        untouchableView.frame = view.frame
        view.addSubview(untouchableView)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    
    func removeSpinner() {
        guard spinner.isAnimating else {
            return
        }
        spinner.stopAnimating()
        spinner.removeFromSuperview()
        untouchableView.removeFromSuperview()
    }
}
