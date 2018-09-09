//
//  BaseUITextField+Subs.swift
//  Near
//
//  Created by Behran Kankul on 14.03.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class BaseUITextFieldBold: BaseUITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .bold)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .bold)
    }
    
}

class BaseUITextFieldRegular: BaseUITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .regular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .regular)
    }
    
}
class BaseUITextFieldMedium: BaseUITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .medium)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .medium)
    }
    
}
class BaseUITextFieldLight: BaseUITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .light)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .light)
    }
    
}


