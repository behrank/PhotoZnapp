//
//  ProfileCell.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 7.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class ProfileRowCell : UITableViewCell {
    
    @IBOutlet weak var imgUserProfile: PhotoView!
    @IBOutlet weak var lblUsername: BaseUILabelMedium!
    @IBOutlet weak var lblSentDate: BaseUILabelMedium!
    @IBOutlet weak var lblDescription: BaseUILabelLight!
    @IBOutlet weak var lblTitleAbout: BaseUILabelBold!
    
    func setupUI(data:Photo) {

        imgUserProfile.loadImageUsingUrlString(urlString: data.user.profileImages.medium,completion: nil)
        lblUsername.text = data.user.name
        lblSentDate.text = data.createdAt
        lblDescription.text = data.description ?? ""
        lblTitleAbout.isHidden = lblDescription.text == ""
    }
}
