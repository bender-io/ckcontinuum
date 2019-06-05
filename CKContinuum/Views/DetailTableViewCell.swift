//
//  DetailTableViewCell.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/5/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var post : Post?
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    func updateViews() {
        guard let post = post else { return }
        captionLabel.text = post.caption
        commentCountLabel.text = String(post.commentCount)
    }
    
}
