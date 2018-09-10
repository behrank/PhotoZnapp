//
//  GalleryPresenter.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol GalleryPresentationLogic
{
    func showFeedData(viewModel:Gallery.GetFeed.ViewModel)
    func showNetworkActivity()
    func hideNetworkActivity()
}

class GalleryPresenter: GalleryPresentationLogic
{
    weak var viewController: GalleryDisplayLogic?
    func showFeedData(viewModel:Gallery.GetFeed.ViewModel) {
        viewController?.displayFeeds(viewModel: viewModel)
    }
    func showNetworkActivity(){
        viewController?.displayNetworkActivity()
    }
    func hideNetworkActivity() {
        viewController?.hideNetworkActivity()
    }
}
