//
//  MainTableVC + UITableViewDataSource.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import SDWebImage

extension MainTableVC: UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")! as! UserCell
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UserCell, forItemAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        cell.nameLabel.text = "\(user.lastName) \(user.firstName)"
        cell.emailLabel.text = user.email
        guard let avatarStringUrl = user.avatarURL else { return }
        cell.avatar.sd_setImage(with: URL(string: avatarStringUrl), placeholderImage: UIImage(named: "defAvatar.png"))
        
    }
    
    
    
}


