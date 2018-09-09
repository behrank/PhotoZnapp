//
//  PhotosResponse.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import Foundation
import UIKit

enum ImageSizes {
    case raw
    case full
    case regular
    case small
    case thumb
}


struct Photo : Decodable {
    var id : String = ""
    var width : Int = 0
    var height : Int = 0
    var bgColor : String = ""
    var imageUrls : ImageUrls
    var createdAt : String = ""
    var description : String? = ""
    var user : User
    
    private enum CodingKeys : String ,CodingKey {
        case id = "id"
        case width = "width"
        case height = "height"
        case bgColor = "color"
        case imageUrls = "urls"
        case createdAt = "created_at"
        case description = "description"
        case user = "user"
    }
}

struct User : Decodable {
    var id : String = ""
    var username : String = ""
    var name : String = ""
    var portfolioUrl : String? = ""
    var location : String? = ""
    var profileImages : UserProfileImages
    var totalPhotos : Int = 0
    var totalCollections : Int = 0
    var bio : String? = ""
    
    private enum CodingKeys : String ,CodingKey {
        case id = "id"
        case username = "username"
        case name = "name"
        case portfolioUrl = "portfolio_url"
        case location = "location"
        case profileImages = "profile_image"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case bio = "bio"
    }
}
struct UserProfileImages : Decodable {
    var small : String = ""
    var medium : String = ""
    var large : String = ""
}
struct ImageUrls : Decodable {
    var raw : String = ""
    var full : String = ""
    var regular : String = ""
    var small : String = ""
    var thumb : String = ""
    
    func calculateImageHeightForThumbnail() -> CGFloat{
        
        let queryItems = URLComponents(string: self.thumb)?.queryItems
        let queryParam = queryItems?.filter({$0.name == "w"}).first
        
        guard let height = queryParam?.value else {
            return 0
        }
        
        guard let nmbr = NumberFormatter().number(from: height) else { return 0 }
        return CGFloat(truncating: nmbr)

    }
}
