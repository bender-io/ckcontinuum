//
//  Post.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/4/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit

class Post {
    
    let image : UIImage
    let caption : String
    
    init(image: UIImage = #imageLiteral(resourceName: "placeholder_image"), caption: String) {
        self.image = image
        self.caption = caption
    }
}
