//
//  DetailVC+UITextFieldDelegate.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

extension DetailVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldChanged() {
        
        
        if !firstNameTextField.text!.isEmpty, !lastNameTextField.text!.isEmpty, !emailTextField.text!.isEmpty, emailTextField.text!.isEmail {
            createButton.isEnabled = true
            createButton.setTitleColor(.white, for: .normal)
        } else {
            createButton.isEnabled = false
            createButton.setTitleColor(.lightGray, for: .normal)
        }
    }
}


