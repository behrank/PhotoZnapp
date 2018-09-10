//
//  LandingInteractor.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol LandingBusinessLogic
{

}

protocol LandingDataStore
{

}

class LandingInteractor: LandingBusinessLogic, LandingDataStore
{
    var presenter: LandingPresentationLogic?
    var worker: LandingWorker?
  
}
