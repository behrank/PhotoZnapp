//
//  Globals.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit


let SEARCHRESULT_USERCELL_IDENTIFIER = "SearchResultUserCellIdentifier"
let SEARCHRESULT_USERCELL_NIB = "SearchResultUserCell"

let SEARCHRESULT_CELL_IDENTIFIER = "SearchResultTableViewCellIdentifier"
let SEARCHRESULT_CELL_NIB = "SearchResultTableViewCell"

let HORIZONTAL_CELL_IDENTIFIER = "HorizontalCellIdentifier"
let HORIZONTAL_CELL_NIB = "HorizontalPageViewCell"

let PROFILE_ROWCELL_IDENTIFIER = "ProfileRowCellIdentifier"
let PROFILE_ROWCELL_NIB = "ProfileRowCell"

let PHOTO_CELL_NIB = "PhotoCell"
let PHOTO_CELL_IDENTIFIER = "PhotoCellIdentifier"
let PHOTO_CELL_REUSE = "PhotoCellReuse"

let PHOTO_TABLECELL_IDENTIFIER = "PhotoTableCellIdentifier"
let PHOTO_TABLECELL_REUSE = "PhotoTableCellReuse"
let PHOTO_TABLECELL_NIB = "PhotoTableViewCell"

let KEY_USER_AUTHENTICATED = "userIsAuthenticated"

let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let gridWidth : CGFloat = (screenSize.width/2) - 20
let navigationHeight : CGFloat = 44.0
let statubarHeight : CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight

protocol Parseble {
    func parseToDictionary() -> [String:Any]
}

//MARK: AppDelegate extension
extension AppDelegate {
    
    class var delegate: AppDelegate? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return delegate
    }
}
//MARK: Navigation helper
class NavigationHelper {
    
    class var rootVC : UIViewController? {
        return AppDelegate.delegate?.window?.rootViewController
    }
    
    class var rootVCForAlert : UIViewController? {
        return rootVC?.presented
    }
    
    class var mainTabbar : UITabBarController? {
        guard let root = rootVC as? UITabBarController else { return nil }
        return root
    }
}

//MARK: Storyboard ID's
enum Storyboard : String {
    
    //These are the Storyboard names
    case main = "Dashboard"
    case landing = "Landing"
    enum Identifier : String {
        
        //These are the ViewController Storyboard Identifiers
        case empty = ""
        case landing = "landingVC"
        case dashboard = "baseTabController"
        case pageVC = "pageVC"
        case tableVC = "tableVC"
        case loginVC = "loginVC"
        //Storyboards owning viewcontrollers
        var storyboardName : Storyboard {
            switch self {
            case .landing,.loginVC:
                return .landing
            case .dashboard:
                return .main
            default: return .main
            }
        }
    }
}

//MARK: Font sizes and names */
enum FontType {
    case regular, light, medium, bold
    
    var fontName : String {
        switch self {
        case .regular: return "Ubuntu"
        case .light: return "Ubuntu-Light"
        case .medium: return "Ubuntu-Medium"
        case .bold: return "Ubuntu-Bold"
        }
    }
}

enum FontSize {
    case xxl
    case xl
    case normal
    case xs
    case small
    case none
    
    func toFont() -> CGFloat{
        switch self {
        case .xxl:
            return 18
        case .xl:
            return 16
        case .normal:
            return 14
        case .small:
            return 12
        case .xs:
            return 10
        default:
            return 1
        }
    }
}
