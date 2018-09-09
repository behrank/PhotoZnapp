//
//  PhotoCell.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class PhotoCell : UICollectionViewCell,BKTansitionGridViewProtocol {

    var imageViewContent = PhotoView()
    var imageUrl : String?
    internal func setImageUrl(_ url:String) {
        
        contentView.addSubview(imageViewContent)
        imageUrl = url
        imageViewContent.loadImageUsingUrlString(urlString: imageUrl!)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewContent.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    func snapShotForTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.imageViewContent.image)
        snapShotView.frame = self.imageViewContent.frame
        snapShotView.cornerRadius = 4
        snapShotView.clipsToBounds = true
        return snapShotView
    }
}
