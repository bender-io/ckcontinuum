//
//  Post.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/4/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit
import CloudKit

class Post {
    
    // MARK: - Properties
    var comments : [Comment]
    let caption : String
    var timestamp : Date
    var commentCount : Int
    let ckRecordID : CKRecord.ID
    var photoData : Data?
    var photo : UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        }
        set {
            photoData = newValue?.pngData()
        }
    }
    var imageAsset : CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(ckRecordID.recordName).appendingPathExtension("png")
            do {
                try photoData?.write(to: fileURL)
            } catch {
                print("🐌 Snail it found in \(#function) ; \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    // MARK: - Inits
    init(comments: [Comment] = [], caption: String, timestamp: Date = Date(), commentCount: Int = 0, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), photo: UIImage?) {
        self.comments = comments
        self.caption = caption
        self.timestamp = timestamp
        self.commentCount = commentCount
        self.ckRecordID = ckRecordID
        self.photo = photo
    }
    
    init?(ckRecord: CKRecord) {
        do {
        guard let caption = ckRecord[PostConstants.captionKey] as? String,
            let timestamp = ckRecord[PostConstants.timestampKey] as? Date,
            let commentCount = ckRecord[PostConstants.commentCountKey] as? Int,
            let photoAsset = ckRecord[PostConstants.photoKey] as? CKAsset
            else { return nil }
        
            let photoData = try Data(contentsOf: photoAsset.fileURL!)
            self.comments = []
            self.caption = caption
            self.timestamp = timestamp
            self.commentCount = commentCount
            self.ckRecordID = ckRecord.recordID
            self.photoData = photoData
        } catch {
            print("🦞 Lobster found in \(#function) ; \(error.localizedDescription)")
            return nil
        }
    }
}

extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: PostConstants.typeKey, recordID: post.ckRecordID)
        setValue(post.caption, forKey: PostConstants.captionKey)
        setValue(post.timestamp, forKey: PostConstants.timestampKey)
        setValue(post.commentCount, forKey: PostConstants.commentCountKey)
        setValue(post.imageAsset, forKey: PostConstants.photoKey)
    }
}

