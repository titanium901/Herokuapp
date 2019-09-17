//
//  DetailVC+UIImagePickerControllerDelegate.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

extension DetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickerChouse(picker: UIImagePickerController, isCamera: Bool ) {
        if isCamera {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        auxImageView.image = avatarImage.image
        avatarImage.image = image
        avatarImage.alpha = 0
        
        auxImageView.alpha = 1
        
        picker.dismiss(animated: true) {
            delay(seconds: 0.25) {
                UIView.animate(withDuration: 2) {
                    self.avatarImage.alpha = 1
                    self.auxImageView.alpha = 0
                }
            }
        }
    }
}
