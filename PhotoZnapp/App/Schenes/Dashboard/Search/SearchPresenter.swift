//
//  SearchPresenter.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic
{
    func showSearchResults(viewModel:Search.Make.ViewModel)
    func showNetworkActivity()
    func hideNetworkActivity()
}

class SearchPresenter: SearchPresentationLogic
{
    weak var viewController: SearchDisplayLogic?
    
    func showSearchResults(viewModel:Search.Make.ViewModel) {
        viewController?.displayResults(viewModel: viewModel)
    }
    func showNetworkActivity(){
        viewController?.displayNetworkActivity()
    }
    func hideNetworkActivity() {
        viewController?.hideNetworkActivity()
    }
}
