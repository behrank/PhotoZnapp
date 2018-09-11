//
//  GalleryInteractor.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol GalleryBusinessLogic
{
    func GetPhotoFeed(req: Gallery.GetFeed.Request)
}

protocol GalleryDataStore
{

}

class GalleryInteractor: GalleryBusinessLogic, GalleryDataStore
{
    var presenter: GalleryPresentationLogic?
    var worker = GalleryWorker()
  
    func GetPhotoFeed(req: Gallery.GetFeed.Request) {
        
        presenter?.showNetworkActivity()
        
        worker.callPhotoService(req, completion: { (viewData:Gallery.GetFeed.ViewModel) in
            self.presenter?.showFeedData(viewModel: viewData)
            self.presenter?.hideNetworkActivity()
        }, failure: { (error) in
            //TODO: Custom alert view
        })
    }
}
