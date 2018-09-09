//
//  UILabelExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

extension UILabel {
    
    func createAttributedTextWith(text:String,font:FontType,fontSize:FontSize) {
        let attrString = NSMutableAttributedString(string: text)
        let textString = NSString(string: text)
        
        attrString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:font.fontName,size:fontSize.toFont())!, range: NSRange(location: 0, length: (textString.length)))
        
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = CGFloat(4)
        
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSRange(location: 0, length: (textString.length)))
        
        self.attributedText = attrString
    }
    
    func animateToFont(_ font: UIFont, withDuration duration: TimeInterval,withColor color:UIColor) {
        let oldFont = self.font
        self.font = font
        // let oldOrigin = frame.origin
        let labelScale = oldFont!.pointSize / font.pointSize
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        // let newOrigin = frame.origin
        // frame.origin = oldOrigin
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            //    self.frame.origin = newOrigin
            self.textColor = color
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}
