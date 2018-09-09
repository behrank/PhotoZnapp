//
//  UICollectionViewExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 6.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

var indexPathPointer = "indexPathPointer"

extension UICollectionView{

    func setToIndexPath (_ indexPath : IndexPath){
        objc_setAssociatedObject(self, &indexPathPointer, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func toIndexPath () -> IndexPath {
        let index = self.contentOffset.x/self.frame.size.width
        if index > 0{
            return IndexPath(row: Int(index), section: 0)
        }else if let indexPath = objc_getAssociatedObject(self,&indexPathPointer) as? IndexPath {
            return indexPath
        }else{
            return IndexPath(row: 0, section: 0)
        }
    }
    
    func fromPageIndexPath () -> IndexPath{
        let index : Int = Int(self.contentOffset.x/self.frame.size.width)
        return IndexPath(row: index, section: 0)
    }
}
