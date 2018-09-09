//
//  UITableViewExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

extension UITableView {
    func moveToTop(){
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
