//
//  SearchResultTableViewCell.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class SearchResultTableViewCell : UITableViewCell {
    
    @IBOutlet weak var imgUserProfile: PhotoView!
    @IBOutlet weak var lblUsername: BaseUILabelMedium!
    @IBOutlet weak var lblSentDate: BaseUILabelMedium!
    @IBOutlet weak var imgPhoto: PhotoView!
    @IBOutlet weak var viewImgWrapper: PhotoView!
    
    func setupUI(data:Photo) {
        viewImgWrapper.backgroundColor = UIColor.init(hexString: data.bgColor)
        imgPhoto.loadImageUsingUrlString(urlString: data.imageUrls.regular,isLargeView: false,completion: nil)
        imgPhoto.contentMode = .scaleAspectFill
        imgUserProfile.loadImageUsingUrlString(urlString: data.user.profileImages.medium,isLargeView: false,completion: nil)
        lblUsername.text = data.user.name
        lblSentDate.text = data.createdAt
    }
}
