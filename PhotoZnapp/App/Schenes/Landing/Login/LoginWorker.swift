//
//  LoginWorker.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 2.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

class LoginWorker
{
    func doSetup(_ viewController : LoginViewController) {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
