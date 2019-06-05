//
//  PostController.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/4/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    // MARK: - Singelton
    static let shared = PostController()
    
    // MARK: - Source of Truth Local
    var posts : [Post] = []
    
    // MARK: - CRUD Functions
    func createPostWith(caption: String, image: UIImage) {
        let post = Post(image: image, caption: caption)
        savePost(post: post) { (success) in
            if !success {
                print("Error saving entry to CK in \(#function)") ; return
            }
        }
    }
    
    func savePost(post: Post, completion: @escaping(Bool) -> Void) {
        let postRecord = CKRecord(post: post)
        CKController.shared.privateDB.save(postRecord) { (record, error) in
            if let error = error {
                print("🐥 Error found in \(#function) ; \(error.localizedDescription)")
                completion(false) ; return
            }
            
            guard let record = record,
            let post = Post(ckRecord: record) else { print("No records found in \(#function)") ; completion(false) ; return }
            
            self.posts.append(post)
            print("Record saved!")

        }
    }
}
