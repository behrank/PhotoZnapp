//
//  SearchResultUserCell.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class SearchResultUserCell : UITableViewCell {
    
    @IBOutlet weak var imgUserProfile: PhotoView!
    @IBOutlet weak var lblUsername: BaseUILabelMedium!
    
    func setupUI(data:User) {
        imgUserProfile.loadImageUsingUrlString(urlString: data.profileImages.medium,completion: nil)
        lblUsername.text = data.name
    }
}
