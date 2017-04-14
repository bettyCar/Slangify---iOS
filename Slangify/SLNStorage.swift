//
//  SLNStorage.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 08/04/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class SLNStorage : NSObject {
    
    let thumbnailsRef : String = "thumbnails"
    let videosRef : String = "videos"
    fileprivate let storageRef = FIRStorage.storage().reference()
}

extension SLNStorage : SLNStorageInterface {
    func uploadVideo(videoPath: String, completion: @escaping completionBlock) {
        let videos = storageRef.child(videosRef).child(videoPath)
        upload(ref: videos, url: videoPath, completion: completion)
    }
    func uploadThumbnail(thumbnailPath: String, completion: @escaping completionBlock) {
        let thumbnails = storageRef.child(thumbnailsRef).child(thumbnailPath)
        upload(ref: thumbnails, url: thumbnailPath, completion: completion)
    }
    
    private func upload(ref: FIRStorageReference, url: String, completion: @escaping completionBlock) {
        // Upload url to the path ref
        if let localFile = URL(string: url) {
            ref.putFile(localFile, metadata: nil) { (metadata, error) in
                completion(metadata, error)
            }
        }
    }
}
