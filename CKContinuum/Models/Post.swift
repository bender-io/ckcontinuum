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
        guard let image = ckRecord[RemotePost.imageKey] as? UIImage,
        let caption = ckRecord[RemotePost.captionKey] as? String else { return nil }
        self.init(image: image, caption: caption, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: RemoteRecord.postKey, recordID: post.ckRecordID)
        self.setValue(post.caption, forKey: RemoteRecord.postKey)
        self.setValue(post.image, forKey: RemoteRecord.postKey)
    }
}

