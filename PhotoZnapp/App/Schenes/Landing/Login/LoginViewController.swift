//
//  LoginViewController.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 2.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: class
{

}

class LoginViewController: UIViewController, LoginDisplayLogic
{
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

    @IBOutlet weak var switchRememberMe: UISwitch!
    @IBOutlet weak var btnLoginUser: BaseUIButtonMedium!
    @IBOutlet weak var txtEmail: BaseUITextFieldRegular!
    @IBOutlet weak var txtPassword: BaseUITextFieldRegular!
    
    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        LoginWorker().doSetup(self)
    
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LoginWorker().doSetup(self)
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
        txtEmail.inputType = .email
        txtPassword.inputType = .password
        switchRememberMe.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    //MARK: UI Actions
    @IBAction func validateLogin(_ sender: Any) {
        
    }
}

extension LoginViewController {
    
}
