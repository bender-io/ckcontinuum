//
//  Record+Controller.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/4/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import Foundation
import CloudKit

class CKController {
    
    // MARK: - Singleton
    static let shared = CKController()
    
    var container : CKContainer
    var privateDB : CKDatabase
    var publicDB : CKDatabase
    
    private init() {
        container = CKContainer.default()
        privateDB = container.privateCloudDatabase
        publicDB = container.publicCloudDatabase
    }
}
