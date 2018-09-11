//
//  Loader.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//
import UIKit
import Lottie
class Loader:UIView {
    
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var isOnFire : Bool = false {
        willSet {
            if newValue == isOnFire { return }
            if newValue {
                let animationView = LOTAnimationView(name: "animation-w800-h600")
                animationView.contentMode = .scaleAspectFill
                animationView.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
                self.container.addSubview(animationView)
                animationView.loopAnimation = true
                animationView.play{ (finished) in
                    // Do Something
                }
            } else {
                
                removeFromSuperview()
            }
        }
    }
}
