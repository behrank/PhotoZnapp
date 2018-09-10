//
//  LoginInteractor.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 2.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol LoginBusinessLogic
{

}

protocol LoginDataStore
{

}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
  
}
