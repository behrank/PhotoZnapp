//
//  BKTransition.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 6.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import Foundation
import UIKit

let ANIMATION_DURATION = 0.35
let ANIMATION_SCALE = screenWidth/gridWidth

class BKTransition : NSObject , UIViewControllerAnimatedTransitioning{
    var presenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return ANIMATION_DURATION
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as UIViewController!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as UIViewController!
        let containerView = transitionContext.containerView
        let offsetY : CGFloat = fromViewController!.navigationController!.isNavigationBarHidden ? 0.0 : navigationHeaderAndStatusbarHeight

        if presenting {
            let toView = toViewController!.view!
            containerView.addSubview(toView)
            toView.isHidden = true
            
            let tappedView = (toViewController! as! BKTransitionProtocol).transitionCollectionView()!
            let pageView = (fromViewController as! BKTransitionProtocol).transitionCollectionView()!
            tappedView.layoutIfNeeded()
            
            let indexPath = pageView.fromPageIndexPath()
            let gridView = tappedView.cellForItem(at: indexPath)
            let leftUpperPoint = gridView!.convert(CGPoint.zero, to: toViewController!.view)
            
            let snapShot = (gridView as! BKTansitionGridViewProtocol).snapShotForTransition()
            snapShot?.transform = CGAffineTransform(scaleX: ANIMATION_SCALE, y: ANIMATION_SCALE)
        
            snapShot?.origin(CGPoint(x: 0, y: 0))
            containerView.addSubview(snapShot!)
            
            let scale = (screenWidth)/gridView!.frame.width
            let scaleTrans = CGAffineTransform.init(scaleX: scale, y: scale)

            toView.isHidden = false
            toView.alpha = 1
            toView.transform = scaleTrans
            toView.frame = CGRect(x: -(leftUpperPoint.x * scale),y: -((leftUpperPoint.y) * scale)+offsetY,
                                  width: toView.frame.size.width, height: toView.frame.size.height)
            
            let whiteViewContainer = UIView(frame: screenBounds)
            whiteViewContainer.backgroundColor = UIColor.white
            
            containerView.addSubview(snapShot!)
            containerView.insertSubview(whiteViewContainer, belowSubview: toView)
            
            snapShot?.isHidden = true
            
            UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                
                snapShot?.layer.opacity = 0
                
                toView.transform = CGAffineTransform.identity
                toView.frame = CGRect(x: 0, y: navigationHeaderAndStatusbarHeight, width: toView.frame.size.width, height: toView.frame.size.height);
                toView.alpha = 1
                
            }, completion:{finished in
                if finished {
                    snapShot?.removeFromSuperview()
                    whiteViewContainer.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            })
        }else{
            let fromView = fromViewController!.view!
            let toView = toViewController!.view
            
            let waterFallView : UICollectionView = (fromViewController as! BKTransitionProtocol).transitionCollectionView()
            let pageView : UICollectionView = (toViewController! as! BKTransitionProtocol).transitionCollectionView()
            
            containerView.addSubview(fromView)
            containerView.addSubview(toView!)
            
            let indexPath = waterFallView.toIndexPath()
            let gridView = waterFallView.cellForItem(at: indexPath as IndexPath)
            
            let leftUpperPoint = gridView!.convert(CGPoint.zero, to: nil)
            pageView.isHidden = true
            
            let snapShot = (gridView as! BKTansitionGridViewProtocol).snapShotForTransition()
            containerView.addSubview(snapShot!)
            snapShot?.origin(leftUpperPoint)
        
            let scale = (screenWidth)/gridView!.frame.width
            let scaleTrans = CGAffineTransform.init(scaleX: scale, y: scale)
            
            UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                
                snapShot?.transform = scaleTrans
                snapShot?.frame = CGRect(x: 0, y: offsetY, width: (snapShot?.frame.size.width)!, height: (snapShot?.frame.size.height)!)

                fromView.alpha = 1
                fromView.transform = scaleTrans
                
                fromView.frame = CGRect(x: -(leftUpperPoint.x)*scale,
                                        y: -(leftUpperPoint.y-offsetY)*scale + offsetY,
                                        width: fromView.frame.size.width,
                                        height: fromView.frame.size.height)
            },completion:{finished in
                if finished {
                    snapShot?.isHidden = false
                    snapShot?.removeFromSuperview()
                    pageView.isHidden = false
                    fromView.transform = CGAffineTransform.identity
                    transitionContext.completeTransition(true)
                }
            })
        }
    }
}
