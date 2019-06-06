//
//  Searchable.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/6/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
