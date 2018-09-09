//
//  BaseTextView.swift
//  Near
//
//  Created by Behran Kankul on 15.02.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

enum wordType{
    case hashtag
    case mention
    case moreBtn
    case link
    case none
}
class BaseTextView: UITextView {
    var callBack: ((String, wordType,IndexPath?) -> Void)?
    var indexPathFor:IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    fileprivate func prepare(){
        self.isSelectable = true
        //self.dataDetectorTypes = .link
        self.isUserInteractionEnabled = true
        self.isScrollEnabled = false
    }
    
    func applyAttributesTo(txtt:String) {
        
        //        let normal = Style("Light", {
        //            $0.font = FontAttribute("Ubuntu", size: 16)
        //            $0.color = UIColor.black
        //            $0.lineSpacing = 8
        //        })
        //        let regexp_url = "((?:http|https)://)?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?"
        //
        //        let regexp_email = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //
        //
        //        let rule_email = RegExpPatternStyles(pattern: regexp_email) {
        //            $0.color = UIColor(red:0.47, green:0.13, blue:0.81, alpha:1.0)
        //            $0.lineSpacing = 8
        //            $0.font = FontAttribute("Ubuntu-Medium",size:16)
        //            }!
        //
        //        let rule_url = RegExpPatternStyles(pattern: regexp_url) {
        //            $0.color = UIColor(red:0.47, green:0.13, blue:0.81, alpha:1.0)
        //            $0.lineSpacing = 8
        //            $0.font = FontAttribute("Ubuntu-Medium",size:16)
        //            }!
        //        let attrString = txtt.set(regExpStyles: [rule_email],default:normal)
        let attrString = NSMutableAttributedString(string: txtt)
        let textString = NSString(string: txtt)
        
        attrString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Ubuntu-Light",size:16)!, range: NSRange(location: 0, length: (textString.length)))
        //attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0), range: NSRange(location: 0, length: (textString.length)))
        
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = CGFloat(4)
        
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSRange(location: 0, length: (textString.length)))
        self.attributedText = attrString
    }
    
    
    func prepareAttrText(text:String,useShort:Bool,andCallBack callBack: @escaping (String, wordType,IndexPath?) -> Void,indexPath:IndexPath?) {
        
        self.dataDetectorTypes.insert(UIDataDetectorTypes.link)
        
        self.callBack = callBack
        indexPathFor = indexPath
        let attrString = NSMutableAttributedString(string: text)
        let textString = NSString(string: text)
        
        let font = UIFont(name:"Ubuntu-Medium",size:16)!
        
        attrString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Ubuntu-Light",size:16)!, range: NSRange(location: 0, length: (textString.length)))
        attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: (textString.length)))
        
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = CGFloat(8)
        
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSRange(location: 0, length: (textString.length)))
        
        let charSet = CharacterSet(charactersIn: ", ")
        let words = text.components(separatedBy: charSet)
        
        //Filter to check for the # or @ prefix
        for word in words.filter({$0.hasPrefix("#")}) {
            let range = textString.range(of: word)
            attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.47, green:0.13, blue:0.81, alpha:1.0), range: range)
            attrString.addAttribute(NSAttributedStringKey(rawValue: "Hashtag"), value: 1, range: range)
            attrString.addAttribute(NSAttributedStringKey(rawValue: "Clickable"), value: 1, range: range)
            attrString.addAttribute(NSAttributedStringKey.font, value: font, range: range)
        }
        //        for word in words.filter({$0.hasPrefix("http")}) {
        //            let range = textString.range(of: word)
        //            attrString.addAttribute(NSAttributedStringKey.link, value: word, range: range)
        //            attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.47, green:0.13, blue:0.81, alpha:1.0), range: range)
        //            attrString.addAttribute(NSAttributedStringKey(rawValue: "Link"), value: word, range: range)
        //            attrString.addAttribute(NSAttributedStringKey(rawValue: "Clickable"), value: 1, range: range)
        //            attrString.addAttribute(NSAttributedStringKey.font, value: font, range: range)
        //        }
        if useShort {
            let attrStringMore = NSMutableAttributedString(string: "\n\nDevamını gör")
            attrStringMore.addAttribute(NSAttributedStringKey(rawValue: "MoreBtn"), value: 1, range: NSRange(location: 0, length: (NSString(string:"\n\nDevamını gör").length)))
            attrStringMore.addAttribute(NSAttributedStringKey(rawValue: "Clickable"), value: 1, range: NSRange(location: 0, length: (NSString(string:"\nDevamını gör").length)))
            attrStringMore.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Ubuntu-medium",size:15)!, range: NSRange(location: 0, length: NSString(string:"\n\nDevamını gör").length))
            attrStringMore.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: NSString(string:"\n\nDevamını gör").length))
            attrString.insert(attrStringMore, at: textString.length)
        }
        let tapper = UITapGestureRecognizer(target: self, action: #selector(self.tapRecognized(tapGesture:)))
        addGestureRecognizer(tapper)
        self.attributedText = attrString
    }
    
    @objc func tapRecognized(tapGesture: UITapGestureRecognizer) {
        var wordString: String?         // The String value of the word to pass into callback function
        var char: NSAttributedString!   //The character the user clicks on. It is non optional because if the user clicks on nothing, char will be a space or " "
        var word: NSAttributedString?   //The word the user clicks on
        var isHashtag: AnyObject?
        var isAtMention: AnyObject?
        var isMoreBtn:AnyObject?
        var isLink:AnyObject?
        
        // Gets the range of the character at the place the user taps
        let point = tapGesture.location(in: self)
        let charPosition = closestPosition(to: point)
        if charPosition == nil {
            //ios 9 fix
            return
        }
        let charRange = tokenizer.rangeEnclosingPosition(charPosition!, with: .character, inDirection: 1)
        
        //Checks if the user has tapped on a character.
        if charRange != nil {
            let location = offset(from: beginningOfDocument, to: charRange!.start)
            let length = offset(from: charRange!.start, to: charRange!.end)
            let attrRange = NSMakeRange(location, length)
            char = attributedText.attributedSubstring(from: attrRange)
            print(char.string)
            //If the user has not clicked on anything, exit the function
            if char.string == " "{
                print("User clicked on nothing")
            }
            
            // Checks the character's attribute, if any
            isHashtag = char?.attribute(NSAttributedStringKey(rawValue: "Hashtag"), at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, char!.length)) as AnyObject?
            isAtMention = char?.attribute(NSAttributedStringKey(rawValue: "Mention"), at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, char!.length)) as AnyObject?
            isMoreBtn = char?.attribute(NSAttributedStringKey(rawValue: "MoreBtn"), at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, char!.length)) as AnyObject?
            isLink = char?.attribute(NSAttributedStringKey(rawValue: "Link"), at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, char!.length)) as AnyObject?
            
        }
        
        // Gets the range of the word at the place user taps
        let wordRange = tokenizer.rangeEnclosingPosition(charPosition!, with: .word, inDirection: 1)
        
        /*
         Check if wordRange is nil or not. The wordRange is nil if:
         1. The User clicks on the "#" or "@"
         2. The User has not clicked on anything. We already checked whether or not the user clicks on nothing so 1 is the only possibility
         */
        if wordRange != nil{
            // Get the word. This will not work if the char is "#" or "@" ie, if the user clicked on the # or @ in front of the word
            let wordLocation = offset(from: beginningOfDocument, to: wordRange!.start)
            let wordLength = offset(from: wordRange!.start, to: wordRange!.end)
            let wordAttrRange = NSMakeRange(wordLocation, wordLength)
            word = attributedText.attributedSubstring(from: wordAttrRange)
            wordString = word!.string
        }else{
            /*
             Because the user has clicked on the @ or # in front of the word, word will be nil as
             tokenizer.rangeEnclosingPosition(charPosition!, with: .word, inDirection: 1) does not work with special characters.
             What I am doing here is modifying the x position of the point the user taps the screen. Moving it to the right by about 12 points will move the point where we want to detect for a word, ie to the right of the # or @ symbol and onto the word's text
             */
            var modifiedPoint = point
            modifiedPoint.x += 12
            let modifiedPosition = closestPosition(to: modifiedPoint)
            let modifedWordRange = tokenizer.rangeEnclosingPosition(modifiedPosition!, with: .word, inDirection: 1)
            if modifedWordRange != nil{
                let wordLocation = offset(from: beginningOfDocument, to: modifedWordRange!.start)
                let wordLength = offset(from: modifedWordRange!.start, to: modifedWordRange!.end)
                let wordAttrRange = NSMakeRange(wordLocation, wordLength)
                word = attributedText.attributedSubstring(from: wordAttrRange)
                wordString = word!.string
            }
        }
        
        if let stringToPass = wordString{
            // Runs callback function if word is a Hashtag or Mention
            if isHashtag != nil && callBack != nil {
                callBack!(stringToPass, wordType.hashtag,nil)
            } else if isAtMention != nil && callBack != nil {
                callBack!(stringToPass, wordType.mention,nil)
            }
            else if isMoreBtn != nil && callBack != nil {
                callBack!(stringToPass,wordType.moreBtn,indexPathFor)
            }
            else if isLink != nil && callBack != nil {
                callBack!(stringToPass,wordType.link,nil)
            }
            else{
                callBack!("move", wordType.none,indexPathFor)
            }
        }
    }
}

