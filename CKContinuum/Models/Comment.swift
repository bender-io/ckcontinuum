//
//  Comment.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/5/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    
    // MARK: - Properties
    weak var post : Post?
    
    let timestamp : Date
    let text : String
    let ckRecordID : CKRecord.ID
    
    var postReference : CKRecord.Reference? {
        guard let post = post else { return nil }
        return CKRecord.Reference(recordID: post.ckRecordID, action: .deleteSelf)
    }
    
    init(post: Post, timestamp: Date = Date(), text: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString) ) {
        self.post = post
        self.timestamp = timestamp
        self.text = text
        self.ckRecordID = ckRecordID
        
    }
    
    convenience init?(ckRecord: CKRecord, post: Post) {
        guard let timestamp = ckRecord[CommentConstants.timestampKey] as? Date,
            let text = ckRecord[CommentConstants.textKey] as? String else { return nil }
        self.init(post: post, timestamp: timestamp, text: text, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init(comment: Comment) {
        self.init(recordType: CommentConstants.typeKey, recordID: comment.ckRecordID)
        setValue(comment.timestamp, forKey: CommentConstants.timestampKey)
        setValue(comment.text, forKey: CommentConstants.textKey)
    }
}
