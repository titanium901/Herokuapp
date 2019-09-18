//
//  DetailVC.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet var auxImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var user: User!
    var isCamer = UIImagePickerController.isSourceTypeAvailable(.camera)
    var buttonLabel: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.setTitle(buttonLabel, for: .normal)
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        
        setUser(user)
    }
    
    func setUser(_ user: User?) {
        activityIndicator.stopAnimating()
        guard let user = user else { return }
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        emailTextField.text = user.email
        guard let avatarStrUrl = user.avatarURL, user.avatarURL != "" else { return }

        activityIndicator.startAnimating()
        avatarImage.sd_setImage(with: URL(string: avatarStrUrl)) { [weak self] (_, error, _, _) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self?.activityIndicator.stopAnimating()
            }
            
        }

    }
 
   
    @IBAction func backButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postAction(_ sender: UIButton) {
        guard !firstNameTextField.text!.isEmpty, !lastNameTextField.text!.isEmpty, !emailTextField.text!.isEmpty else { return }
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        
        switch sender.titleLabel?.text {
        case "POST":
            //Post User
            let postUser = User(firstName: firstName, lastName: lastName, email: email)
            let postUserRequest = UserReguest()
            postUserRequest.request(user: postUser, httpMethod: "POST")
            print("POST")
        case "PATCH":
            //Patch user
            var patchUser = User(firstName: firstName, lastName: lastName, email: email)
            patchUser.id = user.id
            guard let userId = patchUser.id else { return }
            print(patchUser)
            let patchUserReguest = UserReguest(userId: userId)
            patchUserReguest.request(user: patchUser, httpMethod: "PATCH")
            print("Patch")
        default:
            break
        }
        
        
    }
    
    
    @IBAction func changeAvatar(_ sender: UITapGestureRecognizer) {
        print("Tap")
        let ac = UIAlertController(title: "Take Photo", message: "Where do you want to take a photo?", preferredStyle: .actionSheet)
        
        if !isCamer {
            let camera = UIAlertAction(title: "Camera not available", style: .default)
            camera.isEnabled = false
            ac.addAction(camera)
        } else {
            let cameraAv = UIAlertAction(title: "Camera", style: .default) { _ in
                let picker = UIImagePickerController()
                self.pickerChouse(picker: picker, isCamera: true)
            }
            ac.addAction(cameraAv)
        }
        
        let libary = UIAlertAction(title: "Photo Libary", style: .default) { _ in
            let picker = UIImagePickerController()
            self.pickerChouse(picker: picker, isCamera: false)
        }
        ac.addAction(libary)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    
}



