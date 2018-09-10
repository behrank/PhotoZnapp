//
//  AnimatedNavigationController.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 11.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class AnimatedNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.isTranslucent = false
    }
    override func popViewController(animated: Bool) -> UIViewController
    {
        let childrenCount = self.viewControllers.count
        let toViewController = self.viewControllers[childrenCount-2] as! BKGalleryControllerProtocol
        let toView = toViewController.transitionCollectionView()
        let popedViewController = self.viewControllers[childrenCount-1] as! UICollectionViewController
        let popView  = popedViewController.collectionView!;
        let indexPath = popView.fromPageIndexPath()
        toViewController.viewWillAppearWithPageIndex(indexPath.row)
        toView?.setToIndexPath(indexPath)
        return super.popViewController(animated: animated)!
    }
}
