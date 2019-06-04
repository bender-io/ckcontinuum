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
    
    let image : UIImage
    let caption : String
    let ckRecordID : CKRecord.ID
    
    init(image: UIImage = #imageLiteral(resourceName: "placeholder_image"), caption: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.image = image
        self.caption = caption
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let image = ckRecord[PostRecord.imageKey] as? UIImage,
        let caption = ckRecord[PostRecord.captionKey] as? String else { return nil }
        self.init(image: image, caption: caption, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: Record.postKey, recordID: post.ckRecordID)
        self.setValue(post.caption, forKey: Record.postKey)
        self.setValue(post.image, forKey: Record.postKey)
    }
}

//convenience init(entry: Entry) {
//    self.init(recordType: JournalRecord.entryKey, recordID: entry.ckRecordID)
//    self.setValue(entry.title, forKey: JournalEntry.titleKey)
//    self.setValue(entry.body, forKey: JournalEntry.bodyKey)
//    self.setValue(entry.timeStamp, forKey: JournalEntry.timeStampKey)
//}
