//
//  BaseUILabel+Subs.swift
//  Near
//
//  Created by Behran Kankul on 4.02.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class BaseUILabelMedium: BaseUILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .medium)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .medium)
    }
}
class BaseUILabelLight: BaseUILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .light)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .light)
    }
}
class BaseUILabelBold: BaseUILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .bold)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .bold)
    }
}
class BaseUILabelRegular: BaseUILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .regular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .regular)
    }
}
