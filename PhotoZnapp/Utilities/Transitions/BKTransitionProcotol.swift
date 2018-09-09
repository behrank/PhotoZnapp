//
//  BKTransitionProcotol.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 6.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import Foundation
import UIKit

@objc protocol BKTransitionProtocol{
    func transitionCollectionView() -> UICollectionView!
}

@objc protocol BKTansitionGridViewProtocol{
    func snapShotForTransition() -> UIView!
}

@objc protocol BKGalleryControllerProtocol : BKTransitionProtocol{
    func viewWillAppearWithPageIndex(_ pageIndex : NSInteger)
}

@objc protocol BKPageViewControllerProtocol : BKTransitionProtocol{
    func pageViewCellScrollViewContentOffset() -> CGPoint
}
