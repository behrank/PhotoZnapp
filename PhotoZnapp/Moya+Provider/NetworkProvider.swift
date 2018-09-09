//
//  NetworkProvider.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider : MoyaProvider<NetworkAPI> { get }
    /**
     Sends a request with completion and failure completion blocks
     - parameter target: NearAPI item
     - returns: If success returns an ApiResponse object
     */
    func call<T: Decodable>(target:NetworkAPI, completion:@escaping (T) -> (), failureCompletion:@escaping (String?)-> Void)
}

struct NetworkManager: Networkable {
    var provider = MoyaProvider<NetworkAPI>()
    func call<T: Decodable>(target:NetworkAPI, completion:@escaping (T) -> (), failureCompletion:@escaping (String?)-> Void) {
        provider.request(target) { result in
            
            if result.value == nil {
                return failureCompletion("NEMessage.alert.errorServerErrorText")
            }
            
            switch result.value!.statusCode {
            case 200:
                do {
                    let data = try JSONDecoder().decode(T.self, from: result.value!.data)
                    debugPrint(String(data:  result.value!.data, encoding: .utf8) ?? "")
                    completion(data)
                }
                catch let jsonErr{
                    debugPrint(jsonErr)
                    return failureCompletion("NEMessage.alert.errorServerErrorText")
                }
                return
            case 500:
                return failureCompletion("NEMessage.alert.errorServerErrorText")
            case 400:
                return failureCompletion("NEMessage.alert.errorAuthenticationNotValidText")
            default:
                return failureCompletion("NEMessage.alert.errorServerErrorText")
            }
        }
    }
}
