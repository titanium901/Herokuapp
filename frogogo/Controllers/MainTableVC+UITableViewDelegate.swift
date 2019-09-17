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
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC else { return }
        present(detailVC, animated: true, completion: nil)
    }
}
