//
//  PhotoTableViewCell.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 7.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class PhotoTableViewCell : UITableViewCell {
    
    var cellData : Photo!
    @IBOutlet weak var cellImage: PhotoView!
    @IBOutlet weak var consImageViewHeight: NSLayoutConstraint!
    
    internal func setupCell(photo: Photo,cellHeight:CGFloat) {
        cellData = photo
        cellImage.backgroundColor = UIColor.init(hexString: photo.bgColor)
        cellImage.loadImageUsingUrlString(urlString: photo.imageUrls.regular)
        consImageViewHeight.constant = cellHeight + 100
        self.contentView.layoutIfNeeded()
    }
}
