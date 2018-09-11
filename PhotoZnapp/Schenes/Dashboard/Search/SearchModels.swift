//
//  SearchModels.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

enum SearchTypes {
    case user
    case photo
}

enum Search
{
    // MARK: Use cases
  
    enum Make {
        struct Request
        {
            var keyword : String = ""
            var page : Int?
            var type : SearchTypes
            init(word:String, page:Int,searchFor:SearchTypes) {
                self.keyword = word
                self.page = page
                self.type = searchFor
            }
            
            func requestAsTarget() ->NetworkAPI {
                return NetworkAPI.makeSearch(req:self)
            }
        }
        struct ViewModel
        {
            var photos:[Photo]
            var users:[User]
            init(photoList:[Photo], userList:[User]) {
                self.photos = photoList
                self.users = userList
            }
        }
    }
}
