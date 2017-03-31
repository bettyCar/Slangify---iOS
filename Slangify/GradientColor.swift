//
//  GradientColor.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 11/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    let gl: CAGradientLayer
    
    init() {
        let color1 : CGColor = UIColor(red: 48.0/255.0, green: 35.0/255.0, blue: 174.0/255.0, alpha: 1.0).cgColor
        let color2 : CGColor = UIColor(red: 53.0/255.0, green: 37.0/255.0, blue: 175.0/255.0, alpha: 1.0).cgColor
        let color3 : CGColor = UIColor(red: 119.0/255.0, green: 0.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor
        let color4 : CGColor = UIColor(red: 201.0/255.0, green: 109.0/255.0, blue: 216.0/255.0, alpha: 1.0).cgColor
        gl = CAGradientLayer()
        gl.colors = [ color1, color2, color3, color4]
        gl.locations = [0.0, 0.3, 0.6, 1.0]
    }
}
