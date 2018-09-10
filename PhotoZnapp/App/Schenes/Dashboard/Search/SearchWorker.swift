//
//  SearchWorker.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

class SearchWorker : BaseWorker
{
    func doSetup(_ viewController : SearchViewController) {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func callPhotoServiceForPhotoSearch(_ req:Search.Make.Request,completion:@escaping (Search.Make.ViewModel)->Void,failure:@escaping (String)->Void) {
        
        networkProvider.call(target: req.requestAsTarget(), completion: { (res: SearchPhotoResponse?) in
            
            guard let photoList = res?.results else {
                completion(Search.Make.ViewModel.init(photoList: [],userList: []))
                return
            }
            
            completion(Search.Make.ViewModel.init(photoList: photoList,userList: [])) // ?? operator can be use
            
        }, failureCompletion:{ error in
            failure("")
        })
    }
    func callPhotoServiceForUserSearch(_ req:Search.Make.Request,completion:@escaping (Search.Make.ViewModel)->Void,failure:@escaping (String)->Void) {
        
        networkProvider.call(target: req.requestAsTarget(), completion: { (res: SearchUserResponse?) in
            
            guard let userList = res?.results else {
                completion(Search.Make.ViewModel.init(photoList: [],userList: []))
                return
            }
            
            completion(Search.Make.ViewModel.init(photoList: [],userList: userList)) // ?? operator can be use

        }, failureCompletion:{ error in
            failure("")
        })
    }
}
