//
//  LoginModels.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 2.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

enum Login
{
    // MARK: Use cases
    struct Request:Parseble
    {
        var email:String
        var password:String
        
        init(email:String,password:String) {
            self.email = email
            self.password = password
        }
        func parseToDictionary() -> [String : Any] {
            return ["email" : self.email,"password":self.password]
        }
        func validate() ->String{
            if !isValid(self.email)  {
               return "Please provide a valid email address"
            }
            if password.count < 6 || password == ""  {
                return "Password legnth must be higher than 5 characters"
            }
            return ""
        }
        private func isValid(_ email: String) -> Bool {
            let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
    }
}
