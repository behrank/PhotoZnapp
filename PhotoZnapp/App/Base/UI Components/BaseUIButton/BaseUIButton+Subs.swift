//
//  BaseUIButton+Subs.swift
//  Near
//
//  Created by Behran Kankul on 4.02.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class BaseUIButtonRegular: BaseUIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .regular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .regular)
    }
    
}
class BaseUIButtonMedium: BaseUIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .medium)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .medium)
    }
    
}
import UIKit

class BaseUIButtonLight: BaseUIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .light)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .light)
    }
    
}
class BaseUIButtonBold: BaseUIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .bold)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .bold)
    }
    
}
