//
//  MainTableVC+UITableViewDelegate.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

extension MainTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let user = users[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC else { return }
        detailVC.user = user
        detailVC.indexPath = indexPath
        detailVC.buttonLabel = "PATCH"
        present(detailVC, animated: true, completion: nil)
    }
}
