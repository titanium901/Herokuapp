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
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
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
    
        observer = NotificationCenter.default.addObserver(forName: .updateUser, object: nil, queue: .main, using: { (notification) in
            let detailVC = notification.object as! DetailVC
            if detailVC.isPatch {
                self.users[detailVC.indexPath.row] = detailVC.patchUser
                self.tableView.reloadRows(at: [detailVC.indexPath], with: .none)
            }
          
        })
        
        observer = NotificationCenter.default.addObserver(forName: .addUser, object: nil, queue: .main, using: { (notification) in
            let detailVC = notification.object as! DetailVC
            if detailVC.isPost {
                let indexPathFirstRow = IndexPath(row: 0, section: 0)
                let user = detailVC.postUser
                self.users.insert(user!, at: 0)
                self.tableView.insertRows(at: [indexPathFirstRow], with: .fade)
            }
            
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC else { return }
        detailVC.buttonLabel = "POST"
        present(detailVC, animated: true, completion: nil)
    }
    
    
}


