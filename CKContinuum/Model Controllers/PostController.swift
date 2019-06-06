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
    private init () {}
    
    // MARK: - Source of Truth Local
    var posts : [Post] = []
    
    // MARK: - CRUD Methods
    func createPostWith(caption: String, photo: UIImage, completion: @escaping(Post?) -> Void) {
        
        let post = Post(caption: caption, photo: photo)
        self.posts.append(post)
        
        let record = CKRecord(post: post)
        CKController.shared.publicDB.save(record) { (record, error) in
            if let error = error {
                print("🐢 Turtle found in \(#function) ; \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let record = record,
            let post = Post(ckRecord: record) else { completion(nil) ; return }
            completion(post)
        }
    }
    
    func savePost(post: Post, completion: @escaping(Bool) -> Void) {
       
        let postRecord = CKRecord(post: post)
        CKController.shared.publicDB.save(postRecord) { (record, error) in
            if let error = error {
                print("🐥 Error found in \(#function) ; \(error.localizedDescription)")
                completion(false) ; return
            }
            
            guard let record = record,
            let post = Post(ckRecord: record) else { print("No records found in \(#function)") ; completion(false) ; return }
            
            self.posts.append(post)
            print("Record saved!")
            completion(true)

        }
    }
    
    func fetchPosts(completion: @escaping([Post]?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: PostConstants.typeKey, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: PostConstants.timestampKey, ascending: false)]

        CKController.shared.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("🐰 Bunny found in \(#function) ; \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let records = records else { print("🐶 Dog found while looking for fetchRecords in \(#function)") ; completion([]) ; return }
            
            print("Fetching Records!")
            let posts = records.compactMap { Post(ckRecord: $0) }
            self.posts = posts
            completion(posts)
        }
    }
}
