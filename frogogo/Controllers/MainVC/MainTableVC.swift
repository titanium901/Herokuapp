//
//  MainTableVC.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class MainTableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.reloadData()
                }
                
            }

        }

    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC else { return }
        detailVC.buttonLabel = "POST"
        present(detailVC, animated: true, completion: nil)
    }
    
    
}


