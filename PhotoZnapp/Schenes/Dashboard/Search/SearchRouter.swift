//
//  SearchRouter.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol SearchRoutingLogic
{
    func routeToImageDetail(viewData:[Photo],indexPath:IndexPath)
}

protocol SearchDataPassing
{
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing
{
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
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
