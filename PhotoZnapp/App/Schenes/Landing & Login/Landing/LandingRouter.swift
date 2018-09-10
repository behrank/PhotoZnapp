//
//  LandingRouter.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

@objc protocol LandingRoutingLogic
{
    func routeToLogin()
}

protocol LandingDataPassing
{
    var dataStore: LandingDataStore? { get }
}

class LandingRouter: NSObject, LandingRoutingLogic, LandingDataPassing
{
    weak var viewController: LandingViewController?
    var dataStore: LandingDataStore?
    
    //MARK : Routing
    func routeToLogin() {
        let destination = LoginViewController.fromStoryboard(.loginVC)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
