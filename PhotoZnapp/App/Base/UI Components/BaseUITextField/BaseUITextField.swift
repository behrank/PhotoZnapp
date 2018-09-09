//
//  BaseUITextField.swift
//

import UIKit

public enum InputType : Int {
    case `default`,email, password
    
    var maxLenght : Int? {
        switch self {
        case .email: return 250
        case .password: return 30
        default: return nil
        }
    }

    var minLenght : Int {
        switch self {
        case .email: return 1
        case .password: return 6
        default: return 0
        }
    }
}

class BaseUITextField: UITextField {

    var inputType : InputType = .default
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
        font = UIFont(name: type.fontName, size: font?.pointSize ?? 12)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setCustomFont(with: fontType)
    }

}

extension UITextField {
    
    //MARK: Helpers
    func isValidEmailAddress(_ address: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: address)
    }
    func checkTextLenghtFor(type:InputType) -> Bool{
        guard let text = self.text else { return false }
        return text.count > type.minLenght
    }
}
