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
    }
    struct Response {
//        var result:UserResponse
//        var isSuccess:Bool = false
//        init(_ result:UserResponse) {
//            self.result = result
//            self.isSuccess = result.errorMessage == nil
//        }
//        mutating func saveData(){
//
//            AppDelegate.keychain.set(self.result.data?.first?.jwt ?? "", forKey: TAG_KEYCHAIN_JWT)
//            AppDelegate.keychain.set(true, forKey: TAG_KEYCHAIN_AUTHENTICATION)
//            AppDelegate.keychain.set(false, forKey: TAG_KEYCHAIN_AUTHENTICATION_FACEBOOK)
//        }
    }
}
