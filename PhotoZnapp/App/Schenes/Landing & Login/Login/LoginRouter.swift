//
//  LoginRouter.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 2.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

@objc protocol LoginRoutingLogic
{
    func routeToDashboard()
}

protocol LoginDataPassing
{
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing
{
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    //MARK : Routing
    func routeToDashboard() {
        let destination = BaseTabBarController.fromStoryboard(.dashboard)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
