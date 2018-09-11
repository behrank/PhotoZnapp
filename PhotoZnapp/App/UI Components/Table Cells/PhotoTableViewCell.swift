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
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    internal func setupCell(photo: Photo,cellHeight:CGFloat) {
        self.activity.startAnimating()
        cellData = photo
        cellImage.image = UIImage.loadFromCacheFor(url: photo.imageUrls.thumb)
        cellImage.loadImageUsingUrlString(urlString: photo.imageUrls.regular, completion: {
            self.activity.stopAnimating()
        })
        consImageViewHeight.constant = cellHeight
        self.contentView.layoutIfNeeded()
    }
}
