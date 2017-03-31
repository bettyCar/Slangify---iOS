//
//  SLNChallengeInteractor.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 23/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import FirebaseDatabase

// responsible for data

class SLNChallengeInteractor : NSObject {
    
    fileprivate let ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    func getAllLanguages(_ completionBlock:@escaping ([String])->()) {
        DispatchQueue.global().async {
            self.ref.child(FirebaseDataBase.languages.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
                if let languages : [String] = snapshot.value as? [String] {
                    completionBlock(languages)
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func getPhrases(forLanguage languageIndex: Int, completionBlock : @escaping ([Dictionary<String,Any>])->()) {
        DispatchQueue.global().async {
            self.ref.child(FirebaseDataBase.phrases.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
                if let phrasesForLanguage : NSArray = snapshot.value as? NSArray {
                    let phrases : [Dictionary<String,Any>] = phrasesForLanguage[languageIndex] as! [Dictionary<String,Any>]
                    completionBlock(phrases)
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
}
