//
//  PostTableViewController.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/4/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {

    // MARK: - Properties
    var selectedBoop : UIImage?

    @IBOutlet weak var postTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    @IBAction func postButton(_ sender: Any) {
//        if let caption = postTextField.text, !caption.isEmpty,
//            let image = postImage.image {
//            PostController.shared.createPostWith(caption: caption, image: <#T##CKAsset#>)
//        }
//        else { print("🐍 Image and caption not set during \(#function)")}
//    }
}

extension PostTableViewController : BoopTheSnoopViewControllerDelegate {
    
    func boopPickerSelectedWith(boop: UIImage?) {
        guard let boop = boop else { return }
        selectedBoop = boop
    }
}
