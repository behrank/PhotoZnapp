//
//  GalleryRouter.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol GalleryRoutingLogic
{
    func routeToImageDetail(viewData:[Photo],indexPath:IndexPath)
}

protocol GalleryDataPassing
{
    var dataStore: GalleryDataStore? { get }
}

class GalleryRouter: NSObject, GalleryRoutingLogic, GalleryDataPassing
{
    weak var viewController: GalleryViewController?
    var dataStore: GalleryDataStore?
    
    //MARK : Routing
    func routeToImageDetail(viewData:[Photo],indexPath:IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let pageViewController =
            HorizontalPageViewController(collectionViewLayout: layout, currentIndexPath:indexPath)
        pageViewController.imageNameList = viewData
        
        viewController?.navigationController?.pushViewController(pageViewController, animated: true)
    }
}
