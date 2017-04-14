//
//  SLNChallengeViewController.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 11/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import UIKit

// responsible for displaying content and interact with user

class SLNChallengeViewController : UIViewController {
    
    @IBOutlet fileprivate var screenTitile : UILabel!
    @IBOutlet fileprivate var sliderTitle : UILabel!
    @IBOutlet fileprivate var mehTitle : UILabel!
    @IBOutlet fileprivate var ohYesTitle : UILabel!
    @IBOutlet fileprivate var textFieldLine : UIView!
    @IBOutlet fileprivate var languageField : UITextField!
    @IBOutlet fileprivate var picker : UIPickerView!
    @IBOutlet fileprivate var slider : GradientSlider!
    @IBOutlet fileprivate var startButton : UIButton!
    @IBOutlet fileprivate var toolBar : UIToolbar!
    @IBOutlet fileprivate var picketTopConstraint : NSLayoutConstraint!
    
    fileprivate let spinner : SLNSpinner = SLNSpinner()
    
    fileprivate var languagesArray : [String] = []
    fileprivate var languageIndex : Int = 0
    fileprivate var phrase : Phrase?
    fileprivate let interactor : SLNChallengeInteractor = SLNChallengeInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        ReachabilityNotification.observeReachability(listener: self, selector: #selector(self.reachabilityChanged(note:)))
    }
    
    deinit {
        ReachabilityNotification.stopObservingReachbility(listener: self)
    }
    
    func reachabilityChanged(note: NSNotification) {
        if let status = note.object, status is ReachabilityStatus {
            switch status {
            case ReachabilityStatus.resumed:
                if self.languagesArray.count == 0 {
                    getLanguages()
                }
                if let language = languageField.text, language.characters.count > 0 {
                    getPhrase()
                }
            case ReachabilityStatus.stopped:
                print("") // show something
            default: print("")
            }
        }
    }
}

extension SLNChallengeViewController {
    
    func setupView() {
        // background color
        GradientColorDispatcher.setGradient(toView: self.view)
        // can't start a challenge without a phrase
        startButton.isEnabled = false
        languageField.allowsEditingTextAttributes = false
        startButton.backgroundColor = HexColors.green.getColor()
        textFieldLine.backgroundColor = HexColors.lightBlue.getColor()
        languageField.textColor = UIColor.white
        
        getLanguages()
    }
    
    func getLanguages() {
        // show spinner
        spinner.showSpinner(self.view)
        // get all languages and load picker
        interactor.getAllLanguages { (languages) in
            self.languagesArray = languages
            DispatchQueue.main.async(execute: {
                self.picker.reloadAllComponents()
                self.spinner.removeSpinner()
            })
        }
    }
    
    func getPhrase() {
        // show spinner
        self.spinner.showSpinner(self.view)
        // get phrases and randomly pick one
        self.interactor.getPhrases(forLanguage: self.languageIndex, completionBlock: { (phrases) in
            let diceRoll = Int(arc4random_uniform(UInt32(phrases.count)))
            let phraseDict = phrases[diceRoll]
            self.phrase = Phrase(extra: phraseDict[phraseKeys.extra.rawValue] as! String,
                                 score: Float(phraseDict[phraseKeys.score.rawValue] as! Float),
                                 text: phraseDict[phraseKeys.text.rawValue] as! String,
                                 translation: phraseDict[phraseKeys.translation.rawValue] as! String)
            self.startButton.isEnabled = true
            self.languageField.resignFirstResponder()
            self.spinner.removeSpinner()
        })
    }
    
    @IBAction func didPickerDone() {
        // hide picker
        UIView.animate(withDuration: 0.2) {
            self.picketTopConstraint.constant = -self.toolBar.frame.size.height
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        getPhrase()
    }
    
    @IBAction func startChallenge() {
        guard phrase != nil else { return }
        // move to VideoViewController with phrase
        self.performSegue(withIdentifier: "ChallengeAccepted", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let videoViewController = destination as? SLNVideoViewController {
            videoViewController.phrase = self.phrase
        }
    }
}

extension SLNChallengeViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.languageField.resignFirstResponder()
        // show picker
        UIView.animate(withDuration: 0.2, animations: {
            self.picketTopConstraint.constant = self.picker.frame.size.height
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        })
        // show language name in picker
        languageField.text = languagesArray[picker.selectedRow(inComponent: 0)]
    }
}

extension SLNChallengeViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languagesArray.count
    }
}

extension SLNChallengeViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languagesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languageField.text = languagesArray[row]
        self.languageIndex = row
    }
}
