//
//  BaseCollectionViewController.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class BaseCollectionViewController : UICollectionViewController {
    
    private var activityCount = 0 {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.activityCount > 0
            }
        }
    }
    
    //MARK: UI Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tabBarController != nil {
            self.tabBarController!.tabBar.layer.borderWidth = 0.50
            self.tabBarController!.tabBar.layer.borderColor = UIColor.clear.cgColor
            self.tabBarController?.tabBar.clipsToBounds = true
        }
        if shouldListenKeyboardNotification() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShownNotif(_:)), name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotif(_:)), name: .UIKeyboardWillHide, object: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: DeInit
    deinit {
        
        #if DEBUG
        debugPrint("\(NSStringFromClass(self.classForCoder)) deinitialized")
        #endif
        
        if shouldListenKeyboardNotification() {
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        }
    }
    
    //MARK: Internal Funcs
    internal func shouldListenKeyboardNotification() -> Bool {
        return false
    }
    
    internal func keyboardNotification(willShow:Bool,endFrame:CGRect) {
        
    }
    
    internal func navTitle() -> String? {
        return nil
    }
    //MARK: Helper funcs
    func hideNavBarBorder() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    func pushNetworkActivity() {
        activityCount += 1
    }
    
    func popNetworkActivity() {
        if activityCount > 0 { activityCount = 0 }
    }
}
fileprivate extension BaseCollectionViewController {
    
    func handleNavbarTitleView() {
        guard let _ = navTitle() else {
            self.navigationItem.titleView = titleImage
            return
        }
    }
    
    var titleImage : UIImageView {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo_24"))
        return imageView
    }
    
    @objc func keyboardWillShownNotif(_ notification:Notification) {
        self.handleKeyboardNotif(notification: notification, willShow: true)
    }
    
    @objc func keyboardWillHideNotif(_ notification:Notification) {
        self.handleKeyboardNotif(notification: notification, willShow: false)
    }
    
    func handleKeyboardNotif(notification:Notification, willShow:Bool) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewKeyframeAnimationOptions = UIViewKeyframeAnimationOptions(rawValue: animationCurveRaw)
            self.keyboardNotification(willShow: willShow, endFrame: endFrame!)
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: animationCurve, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (finished) in })
        }
    }
}

