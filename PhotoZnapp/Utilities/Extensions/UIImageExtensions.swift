//
//  File.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

extension UIImage {
    
    open class func loadFromCacheFor(url: String) ->UIImage?{
        if let imgFromCache = imageCache.object(forKey: url as NSString) {
            return imgFromCache
        }
        return nil
    }
}
