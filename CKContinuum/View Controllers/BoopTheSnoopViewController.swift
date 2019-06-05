//
//  BoopTheSnoopViewController.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/5/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit

protocol BoopTheSnoopViewControllerDelegate : class{
    func boopPickerSelectedWith(boop: UIImage?)
}

class BoopTheSnoopViewController: UIViewController {

    weak var delegate: BoopTheSnoopViewControllerDelegate?
    
    @IBOutlet weak var currentBoop: UIImageView!
    @IBOutlet weak var boopTheSnoopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func boopTheSnoopBooped(_ sender: Any) {
        imageBooped()
        boopTheSnoopButton.setTitle("", for: .normal)
    }
}

extension BoopTheSnoopViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imageBooped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

