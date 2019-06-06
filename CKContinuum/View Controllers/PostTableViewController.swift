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
    var selectedImage : UIImage?

    // MARK: - IBoutlets
    @IBOutlet weak var captionTextField: UITextField!
    
    // MARK: Lifecycle Methods
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectorVC" {
            let destinationVC = segue.destination as? PhotoSelectorViewController
            destinationVC?.delegate = self
        }
    }
    
//     MARK: - IBOutlets
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let photo = selectedImage,
        let caption = captionTextField.text else { return }
        PostController.shared.createPostWith(caption: caption, photo: photo) { (post) in
            if post == nil {
                print("🙉 Monkey found in \(#function) ; no post found.")
            }
        }
        captionTextField.text = nil
        self.tabBarController?.selectedIndex = 0
    }
}

extension PostTableViewController : PhotoSelectorViewControllerDelegate {
    
    func photoSelectorViewControllerSelected(image: UIImage?) {
        guard let image = image else { return }
        selectedImage = image
    }
}
