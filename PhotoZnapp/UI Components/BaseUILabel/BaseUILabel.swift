//
//  BaseUILabel.swift
//  Near
//
//  Created by Behran Kankul on 4.02.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

class BaseUILabel: UILabel {
    
    var fontType : FontType = .regular {
        didSet {
            if fontType != oldValue {
                setCustomFont(with: fontType)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFont(with: .regular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCustomFont(with: .regular)
    }
    
    func setCustomFont(with type:FontType) {
        fontType = type
        font = UIFont(name: type.fontName, size: font.pointSize)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setCustomFont(with: fontType)
    }
}
