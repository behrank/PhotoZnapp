//
//  NTHorizontalPageViewCell.swift
//  PinterestSwift
//
//  Created by Nicholas Tau on 7/1/14.
//  Copyright (c) 2014 Nicholas Tau. All rights reserved.
//

import Foundation
import UIKit

class HorizontalPageViewCell : UICollectionViewCell {
    var cellInfo : Photo!
    var pullAction : ((_ offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?

    @IBOutlet weak var tableView: UITableView!
    
    internal func setupCell() {

        tableView.register(UINib(nibName: "ProfileRowCell", bundle: nil), forCellReuseIdentifier: "ProfileRowCellIdentifier")
        tableView.register(UINib(nibName: PHOTO_TABLECELL_NIB, bundle: nil), forCellReuseIdentifier: PHOTO_TABLECELL_IDENTIFIER)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        tableView.separatorStyle = .none
    }
    internal func displayData() {
        tableView.reloadData()
    }
    fileprivate func calculateCellHeight() -> CGFloat{
        return (CGFloat(cellInfo.height) * (screenWidth - 20)/CGFloat(cellInfo.width)) + 44
    }
}
extension HorizontalPageViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return calculateCellHeight()
        }
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PHOTO_TABLECELL_IDENTIFIER, for: indexPath) as! PhotoTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileRowCellIdentifier", for: indexPath) as! ProfileRowCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let galleryCell = cell as? PhotoTableViewCell {
            galleryCell.setupCell(photo: cellInfo,cellHeight: calculateCellHeight())
            return
        }
        
        if let profileCell = cell as? ProfileRowCell {
            profileCell.setupUI(data: cellInfo)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tappedAction?()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView : UIScrollView){
        if scrollView.contentOffset.y < navigationHeight{
            pullAction?(scrollView.contentOffset)
        }
    }
}
