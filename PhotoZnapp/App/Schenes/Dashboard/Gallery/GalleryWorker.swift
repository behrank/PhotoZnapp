//
//  GalleryWorker.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

class GalleryWorker:BaseWorker
{
    func doSetup(_ viewController : GalleryViewController) {
        let interactor = GalleryInteractor()
        let presenter = GalleryPresenter()
        let router = GalleryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func callPhotoService(_ req:Gallery.GetFeed.Request,completion:@escaping (Gallery.GetFeed.ViewModel)->Void,failure:@escaping (String)->Void) {
        
        networkProvider.call(target: req.requestAsTarget(), completion: { (res:[Photo]?) in

            guard let photoList = res else {
                completion(Gallery.GetFeed.ViewModel.init(photoList: []))
                return
            }
            
            completion(Gallery.GetFeed.ViewModel.init(photoList: photoList)) // ?? operator can be use
            
        }, failureCompletion:{ error in
            failure("")
        })
    }
}
