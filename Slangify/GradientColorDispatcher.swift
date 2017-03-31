//
//  GradientColorDispatcher.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 11/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit

class GradientColorDispatcher : NSObject {
    class func setGradient(toView view : UIView) {
        view.backgroundColor = UIColor.clear
        let colorView = Colors().gl
        colorView.frame = view.frame
        colorView.startPoint = CGPoint.init(x: 0, y:0)
        colorView.endPoint = CGPoint.init(x: 1, y: 1)
        view.layer.insertSublayer(colorView, at: 0)
    }
}
