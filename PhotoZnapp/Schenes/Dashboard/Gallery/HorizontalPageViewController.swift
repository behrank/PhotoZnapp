//
//  HorizontalPageViewController.swift
//  PinterestSwift
//
//  Created by Nicholas Tau on 7/1/14.
//  Copyright (c) 2014 Nicholas Tau. All rights reserved.
//

import Foundation
import UIKit

class HorizontalPageViewController : UICollectionViewController, BKTransitionProtocol ,BKPageViewControllerProtocol{
    
    var imageNameList = [Photo]()
    var pullOffset = CGPoint.zero
    var currentIndexPath : IndexPath!
    init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: IndexPath){
        super.init(collectionViewLayout:layout)
        let collectionView :UICollectionView = self.collectionView!;
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: HORIZONTAL_CELL_NIB, bundle: nil), forCellWithReuseIdentifier: HORIZONTAL_CELL_IDENTIFIER)
        collectionView.setToIndexPath(indexPath)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.prefetchDataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        currentIndexPath = indexPath
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        collectionView?.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.scrollToItem(at: currentIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let collectionCell: HorizontalPageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HORIZONTAL_CELL_IDENTIFIER, for: indexPath) as! HorizontalPageViewCell
        
        collectionCell.cellInfo = self.imageNameList[indexPath.row]
        collectionCell.tappedAction = {}
        collectionCell.setupCell()
        
        return collectionCell
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let galleryCell = cell as? HorizontalPageViewCell {
            galleryCell.displayData()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imageNameList.count;
    }
    
    func transitionCollectionView() -> UICollectionView!{
        return collectionView
    }
    
    func pageViewCellScrollViewContentOffset() -> CGPoint{
        return CGPoint.init(x: 20, y: 90)
    }
}
extension HorizontalPageViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //TODO: Infinite scroll can be add here
    }
}
extension HorizontalPageViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
