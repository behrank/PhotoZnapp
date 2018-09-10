//
//  SearchInteractor.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic
{
    func GetSearchResults(req: Search.Make.Request)
}

protocol SearchDataStore
{

}

class SearchInteractor: SearchBusinessLogic, SearchDataStore
{
    var presenter: SearchPresentationLogic?
    var worker = SearchWorker()
 
    func GetSearchResults(req: Search.Make.Request) {
        
        presenter?.showNetworkActivity()
        
        if req.type == .photo {
            worker.callPhotoServiceForPhotoSearch(req, completion: { (viewData:Search.Make.ViewModel) in
                self.presenter?.showSearchResults(viewModel: viewData)
                self.presenter?.hideNetworkActivity()
            }, failure: { (error) in
                //TODO: Custom alert view
            })
        }
        else{
            worker.callPhotoServiceForUserSearch(req, completion: { (viewData:Search.Make.ViewModel) in
                self.presenter?.showSearchResults(viewModel: viewData)
                self.presenter?.hideNetworkActivity()
            }, failure: { (error) in
                //TODO: Custom alert view
            })
        }
    }
}
