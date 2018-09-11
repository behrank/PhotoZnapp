//
//  BaseTextView.swift
//  Near
//
//  Created by Behran Kankul on 15.02.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class BaseTextView: UITextView {
    var indexPathFor:IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    fileprivate func prepare(){
        self.isSelectable = true
        self.isUserInteractionEnabled = true
        self.isScrollEnabled = false
    }
}

