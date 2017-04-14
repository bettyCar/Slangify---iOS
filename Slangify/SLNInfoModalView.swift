//
//  SLNInfoModalView.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 02/04/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit
import FLKAutoLayout

class SLNInfoModalView : UIView {
    
    fileprivate let margin : Int = 25
    internal var viewBackgroundColor: UIColor = HexColors.purple.getColor()
    
    init(firstText: String, secondText: String) {
        super.init(frame: .zero)
        setView(firstText: firstText, secondText: secondText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

fileprivate extension SLNInfoModalView {
    
    func setView(firstText: String, secondText: String) {
        self.backgroundColor = viewBackgroundColor
        let firstLabel = labelGenerator()
        firstLabel.text = firstText
        self.addSubview(firstLabel)
        firstLabel.alignLeading(String(margin), trailing: String(-margin), toView: self)
        firstLabel.alignTopEdge(withView: self, predicate: String(margin))
        
        let secondLabel = labelGenerator()
        secondLabel.text = secondText
        self.addSubview(secondLabel)
        secondLabel.alignLeading(String(margin), trailing: String(-margin), toView: self)
        secondLabel.constrainTopSpace(toView: firstLabel, predicate: ">=\(margin)")
        secondLabel.alignBottomEdge(withView: self, predicate: String(-margin))
    }
    
    
    func labelGenerator() -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: RobotoSlabFont.regular.rawValue, size: 28)
        return label
    }
}
