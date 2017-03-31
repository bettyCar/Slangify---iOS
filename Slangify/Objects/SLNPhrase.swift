//
//  SLNPhrase.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 23/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation

struct Phrase {
    
    var extra : String
    var score : Float
    var text : String
    var translation : String
}

enum phraseKeys : String {
    case extra
    case score
    case text
    case translation
}
