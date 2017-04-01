//
//  SLNTranslationView.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 31/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit
import FLKAutoLayout

class SLNTranslationView : UIView {
    
    internal var phrase : Phrase?
    fileprivate let margin : Int = 25
    
    fileprivate let upperView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = HexColors.green.getColor()
        return view
    }()
    
    fileprivate let phraseText : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: RobotoSlabFont.regular.rawValue, size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let phraseTranslation : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: RobotoSlabFont.regular.rawValue, size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let phraseExtra : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: RobotoSlabFont.regular.rawValue, size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(phrase: Phrase) {
        self.phrase = phrase
        super.init(frame: .zero)
        setupUI()
        setUpData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension SLNTranslationView {
    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(upperView)
        upperView.alignTop(String(0), leading: String(0), toView: self)
        upperView.constrainWidth(toView: self, predicate: String(0))
        //upperView.alignBottomEdge(withView: self, predicate: "<= -100")
        
        upperView.addSubview(phraseText)
        phraseText.alignTop(String(margin), bottom: String(-margin), toView: upperView)
        phraseText.alignLeading(String(margin), trailing: String(-margin), toView: upperView)
        
        self.addSubview(phraseTranslation)
        phraseTranslation.alignLeading(String(margin), trailing: String(-margin), toView: self)
        phraseTranslation.constrainTopSpace(toView: upperView, predicate: String(margin))
        
        self.addSubview(phraseExtra)
        phraseExtra.alignLeading(String(margin), trailing: String(-margin), toView: self)
        phraseExtra.constrainTopSpace(toView: phraseTranslation, predicate: String(margin))
        phraseExtra.alignBottomEdge(withView: self, predicate: "<= -\(margin)")
    }
    
    func setUpData() {
        phraseText.text = phrase?.text
        phraseTranslation.text = "Translation: "+(phrase?.translation)!
        phraseExtra.text = phrase?.extra
    }
}
