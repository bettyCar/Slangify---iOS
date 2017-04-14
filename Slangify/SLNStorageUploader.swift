//
//  SLNStorageUploader.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 08/04/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import FirebaseStorage

class SLNStorageUploader : NSObject {
    fileprivate let storage = SLNStorage()
}

extension SLNStorageUploader : SLNStorageUploaderInterface {
    func uploadThumbnail(thumbnailPath: String) {
        storage.uploadThumbnail(thumbnailPath: thumbnailPath) { (metadata, error) in
            guard let metadata = metadata else { return }
            // Save downloadURL to database
            let url = metadata.downloadURL
        }
    }
    
    func uploadVideo(videoPath: String, languageName: String, phrase: Phrase, userId: String) {
        storage.uploadVideo(videoPath: videoPath) { (metadata, error) in
            guard let metadata = metadata else { return }
            // Save downloadURL to database
            let url = metadata.downloadURL
        }
    }
}
