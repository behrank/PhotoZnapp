//
//  LandingWorker.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

class LandingWorker
{
    func doSetup(_ viewController : LandingViewController) {
        let interactor = LandingInteractor()
        let presenter = LandingPresenter()
        let router = LandingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
