//
//  ViewController.swift
//  StoreSearch
//
//  Created by Ajith Anthony on 9/21/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchListTableView: UITableView!
    var storeList: [StoreListViewModel]?
    let storeListDataProvider = StoreListDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpSearchBar()
        
    }
    
    func setUpSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func fetchStoreData(string: String) {
        storeListDataProvider.loadStoreList(from: string, completion: { (result) in
            switch result {
            case .success(let list):
                self.storeList = list
                DispatchQueue.main.async {
                    self.searchListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
                // Handle Error
            }
        })
    }
    
    func validateSearchEvents() -> Bool {
        // Timer will validate the last keystoke time wrt current time. If ist beyond 2sec vaidation will be true else false
        return true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearckResultTableViewCell.identifier, for: indexPath) as? SearckResultTableViewCell, let list = storeList else {
            return UITableViewCell()
        }
        cell.setUI(from: list[indexPath.row])
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count > 2, validateSearchEvents() else {
            return
        }
        fetchStoreData(string: text)
    }
}

