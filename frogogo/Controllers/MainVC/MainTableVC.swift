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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        NotificationCenter.default.addObserver(forName: .updateUser, object: nil, queue: .main, using: { (notification) in
            print("Update User")
            let detailVC = notification.object as! DetailVC
            if detailVC.isPatch {
                self.users[detailVC.indexPath.row] = detailVC.patchUser
                self.tableView.reloadRows(at: [detailVC.indexPath], with: .none)
            }
          
        })
        
         NotificationCenter.default.addObserver(forName: Notification.Name("addUser"), object: nil, queue: .main, using: { (notification) in
            let detailVC = notification.object as! DetailVC
            print("Add New User")
            if detailVC.isPost {
                let user = detailVC.postUser
                self.users.append(user!)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.users.count - 1, section: 0), at: .bottom, animated: false)
            }
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)

    }
    
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        NotificationCenter.default.removeObserver(self)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC else { return }
        detailVC.buttonLabel = "POST"
        present(detailVC, animated: true, completion: nil)
    }
   
}


