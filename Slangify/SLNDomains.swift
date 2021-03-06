//
//  SLNDomains.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 22/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit

enum FirebaseDataBase : String {
    case languages
    case phrases
}

enum HexColors : String {
    case lightBlue = "#50e3c2"
    case green = "#39beac"
    case lightGray = "#fafafa"
    case purple = "#9012fe" //b38f12
}

extension HexColors {
    
    func getColor() -> UIColor {
        var cString:String = self.rawValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


enum RobotoSlabFont : String {
    case regular = "RobotoSlab-Regular"
    case bold = "RobotoSlab-Bold"
}

//extension RobotoSlabFont {
//    
//    func getName() -> String {
//        switch self {
//        case .regular:
//            return "RobotoSlab-Regular"
//        case .bold:
//            return "RobotoSlab-Bold"
//        }
//    }
//}
