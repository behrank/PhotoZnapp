//
//  UITextViewExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

extension UITextView {
    func createAttributedTextWith(text:String,font:FontType,fontSize:FontSize) {
        let attrString = NSMutableAttributedString(string: text)
        let textString = NSString(string: text)
        
        attrString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:font.fontName,size:fontSize.toFont())!, range: NSRange(location: 0, length: (textString.length)))
        
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = CGFloat(4)
        
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSRange(location: 0, length: (textString.length)))
        
        self.attributedText = attrString
    }
    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }
}
