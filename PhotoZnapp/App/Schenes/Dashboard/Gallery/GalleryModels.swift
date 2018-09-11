//
//  GalleryModels.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

enum Gallery
{
    // MARK: Use cases
  
    enum GetFeed {
        struct Request
        {
            var page : Int?
            
            init(nextPage:Int) {
                self.page = nextPage
            }
            
            func requestAsTarget() ->NetworkAPI {
                return NetworkAPI.getFeed(req:self)
            }
        }
        struct ViewModel
        {
            var photos:[Photo]
            init(photoList:[Photo]) {
                self.photos = photoList
            }
        }
    }
}
