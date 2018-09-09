//
//  UIViewControllerExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

extension UIViewController : ModelType { }
extension ModelType where Self : UIViewController {
    static func fromNib(_ nibName : String = String(describing: Self.self)) -> Self {
        return Self(nibName: nibName, bundle: nil)
    }
    
    static func fromStoryboard(_ type : Storyboard.Identifier) -> Self {
        let storyboard : UIStoryboard = UIStoryboard(name: type.storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: type.rawValue) as! Self
    }
}
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    public var presented : UIViewController {
        guard let presentedVC = presentedViewController else { return self }
        return presentedVC
    }
}
