//
//  PostTableViewController.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/4/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {

    @IBOutlet weak var postTextField: UITextField!
    
    @IBOutlet weak var postImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func postButton(_ sender: Any) {
        if let caption = postTextField.text, !caption.isEmpty,
            let image = postImage.image {
            PostController.shared.createPostWith(caption: caption, image: image)
        }
        else { print("🐍 Image and caption not set during \(#function)")}
    }
    
    @IBAction func selectImageGesture(_ sender: Any) {
    }
    
}
