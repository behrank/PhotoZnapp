//
//  NetworkAPI.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//
import Foundation
import Moya

let PAGE_SIZE = 30

enum NetworkAPI {
    case getFeed(req:Gallery.GetFeed.Request)
    case makeSearch(req:Search.Make.Request)
}

// MARK: - TargetType Protocol Implementation
extension NetworkAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getFeed(_), .makeSearch(_):
            return URL(string: "https://api.unsplash.com")!
        }
    }
    
    var path: String {
        switch self {
        case .getFeed(_):
            return "/photos"
        case .makeSearch(let request):
            return request.type == .photo ? "/search/photos" : "/search/users"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getFeed(_), .makeSearch(_):
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getFeed(let request):
            return .requestParameters(parameters: ["per_page" : PAGE_SIZE,"page":request.page ?? 1], encoding: URLEncoding.queryString)
            
        case .makeSearch(let request):
             return .requestParameters(parameters: ["query" : request.keyword,"page":request.page ?? 1,"per_page" : PAGE_SIZE], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        switch self {
        case .getFeed(_), .makeSearch(_):
            return ["Authorization" : "Client-ID 7aa56a55b82a87cabdcad7ab416f053e3309dd47562eeb355537da004de0896c",
                    "Accept-Version" : "v1"]
        }
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
