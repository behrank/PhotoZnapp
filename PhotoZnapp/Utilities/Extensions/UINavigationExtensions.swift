//
//  UINavigationExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 9.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        let fromVCConfromA = (fromVC as? BKTransitionProtocol)
        let fromVCConfromB = (fromVC as? BKGalleryControllerProtocol)
        let fromVCConfromC = (fromVC as? BKPageViewControllerProtocol)
        
        let toVCConfromA = (toVC as? BKTransitionProtocol)
        let toVCConfromB = (toVC as? BKGalleryControllerProtocol)
        let toVCConfromC = (toVC as? BKPageViewControllerProtocol)
        if((fromVCConfromA != nil)&&(toVCConfromA != nil)&&(
            (fromVCConfromB != nil && toVCConfromC != nil)||(fromVCConfromC != nil && toVCConfromB != nil))){
            let transition = BKTransition()
            transition.presenting = operation == .pop
            return  transition
        }else{
            return nil
        }
        
    }
}

