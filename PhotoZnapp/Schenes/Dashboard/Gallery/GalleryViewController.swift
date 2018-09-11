//
//  GalleryViewController.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 5.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol GalleryDisplayLogic: class
{
    func displayFeeds(viewModel:Gallery.GetFeed.ViewModel)
    func hideNetworkActivity()
    func displayNetworkActivity()
}

class GalleryViewController: BaseCollectionViewController, GalleryDisplayLogic,BKTransitionProtocol, BKGalleryControllerProtocol
{
    var interactor: GalleryBusinessLogic?
    var router: (NSObjectProtocol & GalleryRoutingLogic & GalleryDataPassing)?
 
    var loadingView = Loader.fromNib()
    var isInfiniteLoaderTriggered = false
    var viewData = [Photo]()
    {
        didSet {
            if currentPage == 1 {
                loadingView.isOnFire = false
                collectionView?.backgroundView = nil
                collectionView?.reloadData()
                
                if self.collectionView?.layer.opacity == 0.5 {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.collectionView?.layer.opacity = 1
                    })
                    refreshCntrl.endRefreshing()
                }
            }
        }
    }
    
    var currentPage = 1 {
        didSet {
            interactor?.GetPhotoFeed(req: Gallery.GetFeed.Request.init(nextPage: currentPage))
        }
    }
    lazy var refreshCntrl: UIRefreshControl = {
        let refreshCntrl = UIRefreshControl()
        refreshCntrl.addTarget(self, action:
            #selector(GalleryViewController.handleRefresh(_:)),
                               for: UIControlEvents.valueChanged)
        refreshCntrl.tintColor = UIColor.red
        refreshCntrl.tag = 1
        return refreshCntrl
    }()
    let delegateHolder = NavigationControllerDelegate()

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        GalleryWorker().doSetup(self)
    
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        GalleryWorker().doSetup(self)
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupCollectionView()
        setupNavigation()
        
        interactor?.GetPhotoFeed(req: Gallery.GetFeed.Request(nextPage: currentPage))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setupNavigation() {
        self.navigationController!.delegate = delegateHolder
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"close")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"close")
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
        self.navigationController?.navigationBar.topItem?.title = " "
        self.hideNavBarBorder()
    }
    private func setupCollectionView() {
        collectionView?.prefetchDataSource = self
        collectionView?.setCollectionViewLayout(PhotoZnappLayout(), animated: false)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: PHOTO_CELL_IDENTIFIER)
        collectionView?.backgroundView = loadingView
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshCntrl
        } else {
            collectionView?.addSubview(refreshCntrl)
        }

        loadingView.isOnFire = true
        
        if let layout = collectionView?.collectionViewLayout as? PhotoZnappLayout {
            layout.delegate = self
        }
    }
    
    func viewWillAppearWithPageIndex(_ pageIndex: NSInteger) {
        var position: UICollectionViewScrollPosition =
            UICollectionViewScrollPosition.centeredHorizontally.intersection(.centeredVertically)
        
        let image : Photo = viewData[pageIndex]
        let height = CGFloat(image.height) * gridWidth/CGFloat(image.width)
        let imageHeight = height
        if imageHeight > 400 {
            position = .top
        }
        let currentIndexPath = IndexPath(row: pageIndex, section: 0)
        let collectionView = self.collectionView!;
        collectionView.setToIndexPath(currentIndexPath)
        if pageIndex < 2 {
            collectionView.setContentOffset(CGPoint.zero, animated: false)
        } else {
            collectionView.scrollToItem(at: currentIndexPath, at: position, animated: false)
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func transitionCollectionView() -> UICollectionView!{
        return collectionView
    }
    func updateCollectionView(newPhotos:[Photo]) {
        
        collectionView?.setContentOffset(collectionView!.contentOffset, animated: false)
        let cellCountBeforeUpdate = viewData.count
        
        //Update data source
        viewData.append(contentsOf: newPhotos)

        //Update table
        var arrNewIndexes = [IndexPath]()
        for x in cellCountBeforeUpdate...(viewData.count - 1) {
            arrNewIndexes.append(IndexPath(row: x, section: 0))
        }
        self.popNetworkActivity()
        DispatchQueue.main.async {
            self.collectionView?.insertItems(at: arrNewIndexes)
            self.isInfiniteLoaderTriggered = false
        }
    }
}

extension GalleryViewController {
    func displayFeeds(viewModel:Gallery.GetFeed.ViewModel) {
        
        if viewData.count > 0 {
            updateCollectionView(newPhotos:viewModel.photos)
            return
        }
        
        viewData = viewModel.photos
    }
    func hideNetworkActivity() {popNetworkActivity()}
    func displayNetworkActivity() {pushNetworkActivity()}
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        UIView.animate(withDuration: 0.1, animations: {
            self.collectionView?.layer.opacity = 0.5
        }) { (isFinished) in
            
            if isFinished {
                self.viewData.removeAll()
                self.collectionView?.reloadData()
                self.currentPage = 1
            }
        }
    }
    
    //MARK : Collection Cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PHOTO_CELL_IDENTIFIER, for: indexPath) as! PhotoCell
        cell.backgroundColor = UIColor.init(hexString: viewData[indexPath.row].bgColor)
        cell.cornerRadius = 4
        cell.clipsToBounds = true
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let galleryCell = cell as? PhotoCell {
            galleryCell.setImageUrl(viewData[indexPath.row].imageUrls.thumb)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        collectionView.setToIndexPath(indexPath)
        self.tabBarController?.tabBar.isHidden = true
        router?.routeToImageDetail(viewData: viewData, indexPath: indexPath)
    }
}
extension GalleryViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        if isInfiniteLoaderTriggered {
            return
        }
        
        if indexPaths.contains(IndexPath(row: viewData.count-1, section: 0)) {
            currentPage = currentPage + 1
            isInfiniteLoaderTriggered = true
        }
    }
}
extension GalleryViewController : PhotoZnappLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
     
        let image : Photo = viewData[indexPath.row]
        let imageHeight = CGFloat(image.height) * gridWidth/CGFloat(image.width)
        return imageHeight
    }
}
