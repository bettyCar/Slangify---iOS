//
//  SLNStorageInterface.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 08/04/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import FirebaseStorage

protocol SLNStorageInterface {
    
    typealias completionBlock = (_ metadata: FIRStorageMetadata?, _ error: Error?) -> ()
    
    func uploadVideo(videoPath: String, completion: @escaping completionBlock)
    func uploadThumbnail(thumbnailPath: String, completion: @escaping completionBlock)
}

protocol SLNStorageUploaderInterface {
    
    func uploadVideo(videoPath: String, languageName: String, phrase: Phrase, userId: String)
    func uploadThumbnail(thumbnailPath: String)
}
