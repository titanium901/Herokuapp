//
//  ViewController.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let userReguest = UserReguest()
        userReguest.getUsers { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let users):
                self?.users = users
                print(users)
            }

        }

        
    }


}

