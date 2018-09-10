//
//  SearchViewController.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 10.09.2018.
//  Copyright (c) 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: class
{
    func displayResults(viewModel:Search.Make.ViewModel)
    func hideNetworkActivity()
    func displayNetworkActivity()
}

class SearchViewController: BaseViewController, SearchDisplayLogic
{
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    var viewData = Search.Make.ViewModel(photoList: [], userList: [])
    {
        didSet {
            if currentPage == 1 {
                tableSearchResults.isHidden = false
                tableSearchResults?.reloadData()
            }
            searchController.searchBar.endEditing(true)
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var currentPage = 1 {
        didSet {
            if searchController.searchBar.text! == "" {
                return
            }
            interactor?.GetSearchResults(req: Search.Make.Request.init(word: searchController.searchBar.text!,
                                                                             page: currentPage,
                                                                             searchFor: currentFilter == 0 ?
                                                                                        SearchTypes.photo : SearchTypes.user))
        }
    }
    var currentFilter = 0 //Segment
    @IBOutlet weak var tableSearchResults: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SearchWorker().doSetup(self)
    
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SearchWorker().doSetup(self)
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
        self.hideNavBarBorder()
        setupSearchBar()
        setupTableView()
    }
    private func setupTableView() {
        tableSearchResults.register(UINib(nibName: SEARCHRESULT_CELL_NIB, bundle: nil), forCellReuseIdentifier: SEARCHRESULT_CELL_IDENTIFIER)
        tableSearchResults.register(UINib(nibName: SEARCHRESULT_USERCELL_NIB, bundle: nil), forCellReuseIdentifier: SEARCHRESULT_USERCELL_IDENTIFIER)

        tableSearchResults.tableHeaderView = nil
        tableSearchResults.tableFooterView = nil
        tableSearchResults.separatorStyle = .none
        
    }
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Photos"
        searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    private func clearResults() {
        viewData.photos.removeAll()
        viewData.users.removeAll()
        self.tableSearchResults.isHidden = true
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if currentFilter == sender.selectedSegmentIndex {
            return
        }
        else {
            clearResults()
            currentFilter = sender.selectedSegmentIndex
            currentPage = 1
        }
    }
}

extension SearchViewController {
    func displayResults(viewModel:Search.Make.ViewModel) {
        viewData = viewModel
    }
    func hideNetworkActivity() {popNetworkActivity()}
    func displayNetworkActivity() {pushNetworkActivity()}
    
    //Search
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if searchText.count > 3 {
            interactor?.GetSearchResults(req: Search.Make.Request.init(word: searchText, page: currentPage,searchFor: currentFilter == 0 ? SearchTypes.photo : SearchTypes.user))
        }
    }
}
extension SearchViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearResults()
    }
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentFilter == 0 ? viewData.photos.count : viewData.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentFilter == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SEARCHRESULT_CELL_IDENTIFIER, for: indexPath) as! SearchResultTableViewCell
            cell.setupUI(data: viewData.photos[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SEARCHRESULT_USERCELL_IDENTIFIER, for: indexPath) as! SearchResultUserCell
        cell.setupUI(data: viewData.users[indexPath.row])
        return cell
    }
}
extension SearchViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
}

