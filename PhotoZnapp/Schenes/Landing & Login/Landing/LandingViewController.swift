//
//  LandingViewController.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol LandingDisplayLogic: class
{

}

class LandingViewController: BaseViewController, LandingDisplayLogic
{
    var interactor: LandingBusinessLogic?
    var router: (NSObjectProtocol & LandingRoutingLogic & LandingDataPassing)?

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        LandingWorker().doSetup(self)
    
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LandingWorker().doSetup(self)
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavBarBorder()
    }
    
    @IBAction func gotoLogin(_ sender: Any) {
        router?.routeToLogin()
    }
}

